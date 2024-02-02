import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@Riverpod(keepAlive: true)
BalanceRepository _balanceRepository(_BalanceRepositoryRef ref) =>
    BalanceRepositoryImpl();

@riverpod
Future<double> _getBalance(
  _GetBalanceRef ref,
  String address,
  String tokenAddress,
) async {
  return ref.watch(_balanceRepositoryProvider).getBalance(
        address,
        tokenAddress,
      );
}

@Riverpod(keepAlive: true)
Future<Balance?> _getUserTokensBalance(
  _GetUserTokensBalanceRef ref,
) async {
  final session = ref.watch(SessionProviders.session);
  return ref.watch(_balanceRepositoryProvider).getUserTokensBalance(
        session.genesisAddress,
      );
}

abstract class BalanceProviders {
  static const getBalance = _getBalanceProvider;
  static final balanceRepository = _balanceRepositoryProvider;
  static final getUserTokensBalance = _getUserTokensBalanceProvider;
}
