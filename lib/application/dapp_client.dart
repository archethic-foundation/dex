import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dapp_client.g.dart';

@riverpod
awc.ArchethicDAppClient dappClient(DappClientRef ref) =>
    awc.ArchethicDAppClient.auto(
      origin: const awc.RequestOrigin(name: 'aeSwap'),
      replyBaseUrl: '',
    );
