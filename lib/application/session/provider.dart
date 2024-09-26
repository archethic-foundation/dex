/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aedex/application/dapp_client.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Environment environment(EnvironmentRef ref) => ref.watch(
      sessionNotifierProvider.select(
        (session) => session.environment,
      ),
    );

@riverpod
class SessionNotifier extends _$SessionNotifier {
  SessionNotifier();

  StreamSubscription<ArchethicDappConnectionState>?
      _connectionStateSubscription;

  Completer? _connectionCompleter;
  StreamSubscription<ArchethicDappConnectionState>?
      _connectionTaskStateSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      _connectionStateSubscription?.cancel();
    });

    final _archethicDAppClient = ref.watch(dappClientProvider);

    _listenConnectionState(_archethicDAppClient);

    Future.delayed(
      const Duration(milliseconds: 50),
      connectWallet,
    );
    return const Session(
      environment: Environment.mainnet,
      walletConnectionState: awc.ArchethicDappConnectionState.disconnected(),
    );
  }

  /// Connects to AEWallet, and waits for
  /// connection to succeed or fail.
  Future<void> connectWallet() async {
    if (_connectionCompleter != null) return _connectionCompleter!.future;

    final dappClient = ref.read(dappClientProvider);

    _connectionCompleter = Completer();
    _connectionTaskStateSubscription =
        dappClient.connectionStateStream.listen((connectionState) {
      connectionState.maybeWhen(
        connected: () {
          _connectionCompleter?.complete();
          _connectionCompleter = null;
          _connectionTaskStateSubscription?.cancel();
          _connectionTaskStateSubscription = null;
        },
        orElse: () {
          _connectionCompleter?.complete();
          _connectionCompleter = null;
          _connectionTaskStateSubscription?.cancel();
          _connectionTaskStateSubscription = null;
        },
      );
    });

    try {
      await dappClient.connect();
    } catch (e) {
      _handleConnectionFailure();
    }

    return _connectionCompleter?.future;
  }

  void _listenConnectionState(ArchethicDAppClient dappClient) {
    _connectionStateSubscription =
        dappClient.connectionStateStream.listen((connectionState) {
      connectionState.maybeWhen(
        disconnected: _onWalletDisconnected,
        connected: () => _onWalletConnected(dappClient),
        orElse: () => update(
          (state) => state.copyWith(walletConnectionState: connectionState),
        ),
      );
    });
  }

  Future<void> _onWalletDisconnected() async {
    state = const Session(
      environment: Environment.mainnet,
      walletConnectionState: awc.ArchethicDappConnectionState.disconnected(),
    );
  }

  Future<void> _onWalletConnected(ArchethicDAppClient dappClient) async {
    log('Wallet connected');
    try {
      final endpointResult = await dappClient.getEndpoint().valueOrThrow;
      final environment = Environment.byEndpoint(endpointResult.endpointUrl);

      final currentAccount = await dappClient.getCurrentAccount().valueOrNull;

      if (state.environment != environment) {
        final poolsListDatasource = await HivePoolsListDatasource.getInstance();
        await poolsListDatasource.clearAll();
      }

      final subscription = await dappClient.subscribeCurrentAccount();

      await subscription.when(
        success: (success) async => update(
          (state) => state.copyWith(
            environment: environment,
            walletConnectionState:
                const awc.ArchethicDappConnectionState.connected(),
            error: '',
            genesisAddress:
                currentAccount?.genesisAddress ?? state.genesisAddress,
            nameAccount: currentAccount?.shortName ?? state.nameAccount,
            accountSub: success,
            accountStreamSub: success.updates.listen(
              (event) {
                update(
                  (state) => state.copyWith(
                    genesisAddress: event.genesisAddress,
                    nameAccount: event.name,
                  ),
                );
              },
            ),
          ),
        ),
        failure: (failure) async {
          state = state.copyWith(
            walletConnectionState:
                const awc.ArchethicDappConnectionState.disconnected(),
            error: failure.message,
          );
        },
      );
    } catch (e) {
      log('Error wallet connection $e');
      _handleConnectionFailure();
    }
  }

  void _handleConnectionFailure() {
    update((state) {
      final isBrave = BrowserUtil().isBraveBrowser();
      return state.copyWith(
        walletConnectionState:
            const awc.ArchethicDappConnectionState.disconnected(),
        error: isBrave
            ? "Please, open your Archethic Wallet and disable Brave's shield."
            : 'Please, open your Archethic Wallet.',
      );
    });
  }

  Future<void> cancelConnection() async {
    state = state.copyWith(
      walletConnectionState:
          const awc.ArchethicDappConnectionState.disconnected(),
    );
    await ref.read(dappClientProvider).close();
  }

  Future<void> update(FutureOr<Session> Function(Session previous) func) async {
    state = await func(state);
  }
}
