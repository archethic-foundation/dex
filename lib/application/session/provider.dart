/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/repositories/features_flags.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      dev.log('dispose SessionNotifier');
      connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

  Future<void> connectToWallet() async {
    try {
      state = state.copyWith(
        isConnected: false,
        error: '',
      );
      awc.ArchethicDAppClient? archethicDAppClient;
      try {
        archethicDAppClient = awc.ArchethicDAppClient.auto(
          origin: const awc.RequestOrigin(
            name: 'AEDex',
          ),
          replyBaseUrl: 'aedex://archethic.tech',
        );
      } catch (e, stackTrace) {
        dev.log('$e', stackTrace: stackTrace);
        throw const Failure.connectivityArchethic();
      }
      final endpointResponse = await archethicDAppClient.getEndpoint();
      await endpointResponse.when(
        failure: (failure) {
          switch (failure.code) {
            case 4901:
              state = state.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
              break;
            default:
              dev.log(failure.message ?? 'Connection failed');
              state = state.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
              throw const Failure.connectivityArchethic();
          }
        },
        success: (result) async {
          dev.log('DApp is connected to archethic wallet.');

          if (FeatureFlags.mainnetActive == false &&
              result.endpointUrl == 'https://mainnet.archethic.net') {
            state = state.copyWith(
              isConnected: false,
              error:
                  'AEDex is not currently available on the Archethic mainnet.',
            );
            throw Failure.other(cause: state.error);
          }

          state = state.copyWith(endpoint: result.endpointUrl);
          connectionStatusSubscription =
              archethicDAppClient!.connectionStateStream.listen((event) {
            event.when(
              disconnected: () {
                dev.log('Disconnected', name: 'Wallet connection');
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
                dev.log('Connected', name: 'Wallet connection');
                state = state.copyWith(
                  isConnected: true,
                  error: '',
                );
              },
              connecting: () {
                dev.log('Connecting', name: 'Wallet connection');
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
              state = state.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    state = state.copyWith(
                      oldNameAccount: state.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: 'Please, open your Archethic Wallet.',
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
      dev.log(e.toString());
      state = state.copyWith(
        isConnected: false,
        error: 'Please, open your Archethic Wallet.',
      );
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
  }
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}
