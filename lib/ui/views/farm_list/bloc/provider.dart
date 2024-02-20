import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<double> _balance(_BalanceRef ref, String? lpTokenAddress) async {
  final session = ref.watch(SessionProviders.session);
  final balance = await ref.watch(
    BalanceProviders.getBalance(
      session.genesisAddress,
      lpTokenAddress == 'UCO' || lpTokenAddress == null
          ? 'UCO'
          : lpTokenAddress,
    ).future,
  );
  return balance;
}

class FarmListProvider {
  static const balance = _balanceProvider;
}
