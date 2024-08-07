/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;
  awc.ArchethicDAppClient? _archethicDAppClient;

  @override
  Session build() {
    ref.onDispose(() {
      connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

  void invalidateInfos() {
    ref
      ..invalidate(DexTokensProviders.getTokenFromAccount)
      ..invalidate(DexTokensProviders.getTokenFromAddress)
      ..invalidate(DexTokensProviders.getTokenIcon)
      ..read(DexPoolProviders.invalidateData);
  }

  Future<void> updateCtxInfo(BuildContext context) async {
    if (state.isConnected == false && state.endpoint.isEmpty) {
      await connectToWallet(
        forceConnection: false,
      );
    }

    if (state.isConnected == false && state.endpoint.isEmpty) {
      if (context.mounted) {
        connectEndpoint(state.envSelected);
        final preferences = await HivePreferencesDatasource.getInstance();
        aedappfm.sl.get<aedappfm.LogManager>().logsActived =
            preferences.isLogsActived();
      }
    }

    final verifiedTokensNetWork =
        ref.read(aedappfm.VerifiedTokensProviders.verifiedTokens).network;
    if (verifiedTokensNetWork != state.envSelected) {
      log('Loading verified tokens for network ${state.envSelected}');
      await ref
          .read(aedappfm.VerifiedTokensProviders.verifiedTokens.notifier)
          .init(state.envSelected);
    }

    final ucidsTokens = ref.read(aedappfm.UcidsTokensProviders.ucidsTokens);
    if (ucidsTokens.isEmpty) {
      await ref
          .read(aedappfm.UcidsTokensProviders.ucidsTokens.notifier)
          .init(state.envSelected);
    }
    final coinPrice = ref.read(aedappfm.CoinPriceProviders.coinPrice);
    if (coinPrice.timestamp == null) {
      await ref.read(aedappfm.CoinPriceProviders.coinPrice.notifier).init();
    }
  }

  void connectEndpoint(String env) {
    state = state.copyWith(
      envSelected: env,
      isConnected: false,
      error: '',
      endpoint: aedappfm.EndpointUtil.getEnvironnementUrl(env),
    );

    setupServiceLocatorApiService(state.endpoint);
    invalidateInfos();
  }

  void _handleConnectionFailure() {
    final isBrave = BrowserUtil().isBraveBrowser();
    state = state.copyWith(
      isConnected: false,
      error: isBrave
          ? "Please, open your Archethic Wallet and disable Brave's shield."
          : 'Please, open your Archethic Wallet.',
    );
  }

  Future<void> refreshUserBalance() async {
    final userBalance = await BalanceRepositoryImpl().getUserTokensBalance(
      state.genesisAddress,
    );
    state = state.copyWith(userBalance: userBalance);
  }

  Future<void> connectToWallet({
    bool forceConnection = true,
  }) async {
    try {
      state = state.copyWith(
        isConnected: false,
        error: '',
        genesisAddress: '',
        nameAccount: '',
      );

      final client = _getDappClient();

      await client.connect();
    } catch (e) {
      if (forceConnection == true) {
        _handleConnectionFailure();
      }
    }
  }

  awc.ArchethicDAppClient _getDappClient() {
    awc.ArchethicDAppClient buildDappClient() {
      try {
        return awc.ArchethicDAppClient.auto(
          origin: const awc.RequestOrigin(
            name: 'aeSwap',
          ),
          replyBaseUrl: '',
        );
      } catch (e) {
        throw const aedappfm.Failure.connectivityArchethic();
      }
    }

    awc.ArchethicDAppClient prepareDappClient() {
      final archethicDAppClient = buildDappClient();

      connectionStatusSubscription =
          archethicDAppClient.connectionStateStream.listen(
        (event) {
          event.when(
            disconnected: () {
              state = state.copyWith(
                endpoint: '',
                error: '',
                genesisAddress: '',
                nameAccount: '',
                oldNameAccount: '',
                isConnected: false,
              );
            },
            connected: () async {
              try {
                final endpointResult =
                    await archethicDAppClient.getEndpoint().valueOrThrow;

                if (state.endpoint.isNotEmpty &&
                    state.endpoint != endpointResult.endpointUrl) {
                  final poolsListDatasource =
                      await HivePoolsListDatasource.getInstance();
                  await poolsListDatasource.clearAll();
                }

                state = state.copyWith(
                  endpoint: endpointResult.endpointUrl,
                  isConnected: true,
                );
                if (aedappfm.sl.isRegistered<awc.ArchethicDAppClient>()) {
                  aedappfm.sl.unregister<awc.ArchethicDAppClient>();
                }
                aedappfm.sl.registerLazySingleton<awc.ArchethicDAppClient>(
                  () => archethicDAppClient,
                );

                setupServiceLocatorApiService(endpointResult.endpointUrl);
                final preferences =
                    await HivePreferencesDatasource.getInstance();
                aedappfm.sl.get<aedappfm.LogManager>().logsActived =
                    preferences.isLogsActived();

                // final currentAccountResponse =
                //     await archethicDAppClient.getCurrentAccount();
                // currentAccountResponse.when(
                //   success: (currentAccount) {
                //     state = state.copyWith(
                //       oldNameAccount: state.nameAccount,
                //       genesisAddress: currentAccount.genesisAddress,
                //       nameAccount: currentAccount.shortName,
                //     );
                //   },
                //   failure: (_) {},
                // );
                final subscription =
                    await archethicDAppClient.subscribeCurrentAccount();

                await subscription.when(
                  success: (success) async {
                    connectEndpoint(aedappfm.EndpointUtil.getEnvironnement());
                    final preferences =
                        await HivePreferencesDatasource.getInstance();
                    aedappfm.sl.get<aedappfm.LogManager>().logsActived =
                        preferences.isLogsActived();
                    invalidateInfos();
                    state = state.copyWith(
                      accountSub: success,
                      error: '',
                      isConnected: true,
                      envSelected: aedappfm.EndpointUtil.getEnvironnement(),
                      accountStreamSub: success.updates.listen((event) {
                        state = state.copyWith(
                          oldNameAccount: state.nameAccount,
                          genesisAddress: event.genesisAddress,
                          nameAccount: event.name,
                        );
                      }),
                    );
                  },
                  failure: (failure) {
                    state = state.copyWith(
                      isConnected: false,
                      error: failure.message,
                    );
                  },
                );

                state = state.copyWith(
                  isConnected: true,
                  error: '',
                );
              } catch (e) {
                _handleConnectionFailure();
              }
            },
            connecting: () {},
            disconnecting: () {},
          );
        },
      );
      return archethicDAppClient;
    }

    return _archethicDAppClient ??= prepareDappClient();
  }

  void setOldNameAccount() {
    state = state.copyWith(oldNameAccount: state.nameAccount);
  }

  Future<void> cancelConnection() async {
    if (aedappfm.sl.isRegistered<awc.ArchethicDAppClient>()) {
      await aedappfm.sl.get<awc.ArchethicDAppClient>().close();
      await aedappfm.sl.unregister<awc.ArchethicDAppClient>();
    }

    if (aedappfm.sl.isRegistered<ApiService>()) {
      await aedappfm.sl.unregister<ApiService>();
    }

    state = state.copyWith(
      accountSub: null,
      accountStreamSub: null,
      nameAccount: '',
      genesisAddress: '',
    );

    connectEndpoint(state.envSelected);
    final preferences = await HivePreferencesDatasource.getInstance();
    aedappfm.sl.get<aedappfm.LogManager>().logsActived =
        preferences.isLogsActived();
  }
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}
