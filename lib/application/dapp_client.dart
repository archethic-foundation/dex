import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dapp_client.g.dart';

@riverpod
Future<awc.ArchethicDAppClient> dappClient(DappClientRef ref) async {
  final client = await awc.ArchethicDAppClient.auto(
    origin: const awc.RequestOrigin(name: 'aeSwap'),
    replyBaseUrl: '',
  );
  ref.onDispose(client.close);

  return client;
}
