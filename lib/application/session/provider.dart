/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/browser_util.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;

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
      ..invalidate(DexPoolProviders.getPoolInfos)
      ..invalidate(DexPoolProviders.getPoolList)
      ..invalidate(DexPoolProviders.getPoolListFromCache);
  }

  void connectEndpoint(String env) {
    state = state.copyWith(
      envSelected: env,
      isConnected: false,
      error: '',
      endpoint: EndpointUtil.getEnvironnementUrl(env),
    );
    if (sl.isRegistered<ApiService>()) {
      sl.unregister<ApiService>();
    }
    setupServiceLocatorApiService(state.endpoint);
    invalidateInfos();
  }

  void setCacheFirstLoading(bool cacheFirstLoading) {
    state = state.copyWith(cacheFirstLoading: cacheFirstLoading);
  }

  Future<void> connectToWallet({
    bool forceConnection = true,
  }) async {
    var isBrave = false;
    if (kIsWeb == true) {
      if (BrowserUtil().isBraveBrowser()) {
        isBrave = true;
      }
    }

    try {
      state = state.copyWith(
        isConnected: false,
        error: '',
      );
      awc.ArchethicDAppClient? archethicDAppClient;
      try {
        archethicDAppClient = awc.ArchethicDAppClient.auto(
          origin: const awc.RequestOrigin(
            name: 'aeSwap',
          ),
          replyBaseUrl: 'aeswap://archethic.tech',
        );
      } catch (e, stackTrace) {
        sl.get<LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: LogLevel.error,
              name: '_SessionNotifier - connectToWallet',
            );
        throw const Failure.connectivityArchethic();
      }

      final endpointResponse = await archethicDAppClient.getEndpoint();

      await endpointResponse.when(
        failure: (failure) {
          switch (failure.code) {
            case 4901:
              state = state.copyWith(
                isConnected: false,
                error: isBrave
                    ? "Please, open your Archethic Wallet and disable Brave's shield."
                    : 'Please, open your Archethic Wallet.',
              );
              break;
            default:
              state = state.copyWith(
                isConnected: false,
                error: isBrave
                    ? "Please, open your Archethic Wallet and disable Brave's shield."
                    : 'Please, open your Archethic Wallet.',
              );
              throw const Failure.connectivityArchethic();
          }
        },
        success: (result) async {
          state = state.copyWith(endpoint: result.endpointUrl);
          connectionStatusSubscription =
              archethicDAppClient!.connectionStateStream.listen((event) {
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
                state = state.copyWith(
                  isConnected: true,
                  error: '',
                );
              },
              connecting: () {
                state = state.copyWith(
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
              },
            );
          });
          if (sl.isRegistered<ApiService>()) {
            sl.unregister<ApiService>();
          }
          if (sl.isRegistered<awc.ArchethicDAppClient>()) {
            sl.unregister<awc.ArchethicDAppClient>();
          }
          sl.registerLazySingleton<awc.ArchethicDAppClient>(
            () => archethicDAppClient!,
          );
          setupServiceLocatorApiService(result.endpointUrl);
          final subscription =
              await archethicDAppClient.subscribeCurrentAccount();

          await subscription.when(
            success: (success) async {
              connectEndpoint(EndpointUtil.getEnvironnement());
              invalidateInfos();
              state = state.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                envSelected: EndpointUtil.getEnvironnement(),
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    state = state.copyWith(
                      oldNameAccount: state.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: isBrave
                          ? "Please, open your Archethic Wallet and disable Brave's shield."
                          : 'Please, open your Archethic Wallet.',
                      isConnected: false,
                    );
                    return;
                  }
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
                error: failure.message ?? 'Connection failed',
              );
            },
          );
        },
      );
    } catch (e) {
      if (forceConnection == false) {
        state = state.copyWith(
          isConnected: false,
          error: isBrave
              ? "Please, open your Archethic Wallet and disable Brave's shield."
              : 'Please, open your Archethic Wallet.',
        );
      }
    }
  }

  void setOldNameAccount() {
    state = state.copyWith(oldNameAccount: state.nameAccount);
  }

  Future<void> cancelConnection() async {
    if (sl.isRegistered<awc.ArchethicDAppClient>()) {
      await sl.get<awc.ArchethicDAppClient>().close();
      await sl.unregister<awc.ArchethicDAppClient>();
    }

    if (sl.isRegistered<ApiService>()) {
      await sl.unregister<ApiService>();
    }

    state = state.copyWith(
      accountSub: null,
      accountStreamSub: null,
      nameAccount: '',
      genesisAddress: '',
    );

    connectEndpoint(state.envSelected);
  }
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}
