/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  SessionNotifier();

  final _archethicDAppClient = ArchethicDAppClient.auto(
    origin: const RequestOrigin(name: 'aeSwap'),
    replyBaseUrl: '',
  );

  StreamSubscription<ArchethicDappConnectionState>?
      _connectionStateSubscription;

  Completer<void>? _connectCompleter;
  Completer<void>? _disconnectCompleter;

  @override
  Future<Session> build() async {
    ref.onDispose(() {
      _connectionStateSubscription?.cancel();
    });

    await _connectWallet();
    return state.value ?? const Session();
  }

  Future<void> _connectWallet() async {
    _connectionStateSubscription =
        _archethicDAppClient.connectionStateStream.listen((connectionState) {
      connectionState.when(
        disconnected: _onWalletDisconnected,
        connected: _onWalletConnected,
        connecting: _onWalletConnecting,
        disconnecting: _onWalletDisconnecting,
      );
    });

    await _archethicDAppClient.connect();

    if (_connectCompleter != null) {
      await _connectCompleter!.future;
    } else if (_disconnectCompleter != null) {
      await _disconnectCompleter!.future;
    }
  }

  Future<void> _onWalletConnecting() async {
    log('Connecting');
    _connectCompleter = Completer<void>();
  }

  Future<void> _onWalletDisconnecting() async {
    log('Disconnecting');
    _disconnectCompleter = Completer<void>();
  }

  Future<void> _onWalletDisconnected() async {
    log('Wallet disconnected');
    final currentState = state.value ?? const Session();

    final newState = currentState.copyWith(
      endpoint: aedappfm.EndpointUtil.getEnvironnementUrl('mainnet'),
      error: '',
      genesisAddress: '',
      nameAccount: '',
      oldNameAccount: '',
      isConnected: false,
      envSelected: 'mainnet',
      userBalance: const Balance(),
    );
    _updateState(newState);

    await connectEndpointWithoutWallet('mainnet');

    _disconnectCompleter?.complete();
    _disconnectCompleter = null;
  }

  Future<void> _onWalletConnected() async {
    log('Wallet connected');
    final currentState = state.value ?? const Session();

    try {
      final endpointResult =
          await _archethicDAppClient.getEndpoint().valueOrThrow;

      await setupServiceLocatorApiService(endpointResult.endpointUrl);

      if (currentState.endpoint.isNotEmpty &&
          currentState.endpoint != endpointResult.endpointUrl) {
        final poolsListDatasource = await HivePoolsListDatasource.getInstance();
        await poolsListDatasource.clearAll();
      }

      var newState = currentState.copyWith(
        endpoint: endpointResult.endpointUrl,
        isConnected: true,
        error: '',
        envSelected: aedappfm.EndpointUtil.getEnvironnement(),
      );
      _updateState(newState);

      final currentAccountResponse =
          await _archethicDAppClient.getCurrentAccount();
      currentAccountResponse.when(
        success: (currentAccount) {
          newState = newState.copyWith(
            oldNameAccount: newState.nameAccount,
            genesisAddress: currentAccount.genesisAddress,
            nameAccount: currentAccount.shortName,
          );
          _updateState(newState);
        },
        failure: (_) {},
      );

      await _initUCOAEEthInfos();
      await refreshUserBalance();

      final subscription = await _archethicDAppClient.subscribeCurrentAccount();

      await subscription.when(
        success: (success) async {
          invalidateInfos();
          newState = newState.copyWith(
            accountSub: success,
            error: '',
            isConnected: true,
            envSelected: aedappfm.EndpointUtil.getEnvironnement(),
            accountStreamSub: success.updates.listen((event) {
              newState = newState.copyWith(
                oldNameAccount: newState.nameAccount,
                genesisAddress: event.genesisAddress,
                nameAccount: event.name,
              );
            }),
          );
          _updateState(newState);
          await refreshUserBalance();
        },
        failure: (failure) async {
          newState = newState.copyWith(
            isConnected: false,
            error: failure.message,
            endpoint: aedappfm.EndpointUtil.getEnvironnementUrl(
              aedappfm.EndpointUtil.getEnvironnement(),
            ),
            envSelected: aedappfm.EndpointUtil.getEnvironnement(),
          );
          _updateState(newState);
          await connectEndpointWithoutWallet(
            aedappfm.EndpointUtil.getEnvironnement(),
          );
        },
      );
    } catch (e) {
      log('Error wallet connection $e');
      handleConnectionFailure();
    }

    _connectCompleter?.complete();
    _connectCompleter = null;
  }

  Future<void> connectEndpointWithoutWallet(
    String env,
  ) async {
    final currentState = state.value ?? const Session();
    final newState = currentState.copyWith(
      envSelected: env,
      isConnected: false,
      error: '',
      endpoint: aedappfm.EndpointUtil.getEnvironnementUrl(env),
    );
    _updateState(newState);
    await setupServiceLocatorApiService(newState.endpoint);
    invalidateInfos();
    await _initverifiedTokensProvider();
    await _initUCOAEEthInfos();
  }

  Future<void> _initverifiedTokensProvider() async {
    final currentState = state.value ?? const Session();

    final verifiedTokensNetWork =
        ref.read(aedappfm.VerifiedTokensProviders.verifiedTokens).network;
    if (verifiedTokensNetWork != currentState.envSelected) {
      log('Loading verified tokens for network ${currentState.envSelected}');
      await ref
          .read(
            aedappfm.VerifiedTokensProviders.verifiedTokens.notifier,
          )
          .init(currentState.envSelected);
    }
  }

  void handleConnectionFailure() {
    final currentState = state.value ?? const Session();
    final isBrave = BrowserUtil().isBraveBrowser();
    final newState = currentState.copyWith(
      isConnected: false,
      error: isBrave
          ? "Please, open your Archethic Wallet and disable Brave's shield."
          : 'Please, open your Archethic Wallet.',
    );
    _updateState(newState);
  }

  Future<void> refreshUserBalance() async {
    final currentState = state.value ?? const Session();
    final apiService = aedappfm.sl.get<ApiService>();
    var userBalance = const Balance();
    if (currentState.genesisAddress.isNotEmpty) {
      userBalance = await BalanceRepositoryImpl().getUserTokensBalance(
            currentState.genesisAddress,
            apiService,
          ) ??
          const Balance();
    }

    final newState = currentState.copyWith(userBalance: userBalance);
    _updateState(newState);
  }

  Session setOldNameAccount(Session state) {
    return state.copyWith(oldNameAccount: state.nameAccount);
  }

  Future<void> cancelConnection() async {
    final currentState = state.value ?? const Session();
    if (aedappfm.sl.isRegistered<ApiService>()) {
      await aedappfm.sl.unregister<ApiService>();
    }

    final newState = currentState.copyWith(
      accountSub: null,
      accountStreamSub: null,
      nameAccount: '',
      genesisAddress: '',
    );
    _updateState(newState);
    await _archethicDAppClient.close();

    await connectEndpointWithoutWallet(newState.envSelected);
  }

  void invalidateInfos() {
    ref
      ..invalidate(DexTokensProviders.getTokenFromAccount)
      ..invalidate(DexTokensProviders.getTokenFromAddress)
      ..invalidate(DexTokensProviders.getTokenIcon)
      ..invalidate(farmLockFormNotifierProvider)
      ..read(DexPoolProviders.invalidateData);
  }

  void _updateState(Session newState) {
    state = AsyncValue.data(newState);
  }

  Future<void> _initUCOAEEthInfos() async {
    void _getContextAddresses() {
      final currentState = state.value ?? const Session();
      switch (currentState.envSelected) {
        case 'devnet':
          final newState = currentState.copyWith(
            aeETHUCOPoolAddress:
                '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
            aeETHUCOFarmLegacyAddress:
                '00008e063dffde69214737c4e9e65b6d9d5776c5369729410ba25dab0950fbcf921e',
            aeETHUCOFarmLockAddress:
                '00007338a899446b8d211bb82b653dfd134cc351dd4060bb926d7d9c7028cf0273bf',
          );
          _updateState(newState);
          break;
        case 'testnet':
          final newState = currentState.copyWith(
            aeETHUCOPoolAddress:
                '0000818EF23676779DAE1C97072BB99A3E0DD1C31BAD3787422798DBE3F777F74A43',
            aeETHUCOFarmLegacyAddress:
                '0000208A670B5590939174D65F88140C05DDDBA63C0C920582E12162B22F3985E510',
            aeETHUCOFarmLockAddress:
                '0000CAF8D5BAA374A2878FD87760A2A4AC9F5232DBB4F1143157A2006F95FFF1B40E',
          );
          _updateState(newState);
          break;
        case 'mainnet':
        default:
          final newState = currentState.copyWith(
            aeETHUCOPoolAddress:
                '000090C5AFCC97C2357E964E3DDF5BE9948477F7C1DE2C633CDFC95B202970AEA036',
            aeETHUCOFarmLegacyAddress:
                '0000474A5B5D261A86D1EB2B054C8E7D9347767C3977F5FC20BB8A05D6F6AFB53DCC',
            aeETHUCOFarmLockAddress:
                '0000b2339aadf5685b1c8d400c9092c921e51588dc049e097ec9437017e7dded0feb',
          );
          _updateState(newState);
          break;
      }
    }

    _getContextAddresses();

    final currentState = state.value ?? const Session();

    final poolFuture = ref.read(
      DexPoolProviders.getPool(
        currentState.aeETHUCOPoolAddress!,
      ).future,
    );

    final farmFuture = ref.read(
      DexFarmProviders.getFarmInfos(
        currentState.aeETHUCOFarmLegacyAddress!,
        currentState.aeETHUCOPoolAddress!,
        dexFarmInput: DexFarm(
          poolAddress: currentState.aeETHUCOPoolAddress!,
          farmAddress: currentState.aeETHUCOFarmLegacyAddress!,
        ),
      ).future,
    );

    Future<DexFarmLock?>? farmLockFuture;
    if (currentState.aeETHUCOFarmLockAddress!.isNotEmpty) {
      farmLockFuture = ref.read(
        DexFarmLockProviders.getFarmLockInfos(
          currentState.aeETHUCOFarmLockAddress!,
          currentState.aeETHUCOPoolAddress!,
          dexFarmLockInput: DexFarmLock(
            poolAddress: currentState.aeETHUCOPoolAddress!,
            farmAddress: currentState.aeETHUCOFarmLockAddress!,
          ),
        ).future,
      );
    }

    final results = await Future.wait([
      poolFuture,
      farmFuture,
      if (farmLockFuture != null) farmLockFuture,
    ]);

    final pool = results[0] as DexPool?;
    final farm = results[1] as DexFarm?;
    DexFarmLock? farmLock;
    if (farmLockFuture != null) {
      farmLock = results[2] as DexFarmLock?;
    }

    final newState = currentState.copyWith(
      aeETHUCOPool: pool,
      aeETHUCOFarm: farm,
      aeETHUCOFarmLock: farmLock,
    );
    _updateState(newState);
  }
}
