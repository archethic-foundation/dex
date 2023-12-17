import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
BalanceRepository _balanceRepository(_BalanceRepositoryRef ref) =>
    BalanceRepositoryImpl();

@riverpod
Future<double> _getBalance(
  _GetBalanceRef ref,
  String address,
  String tokenAddress,
) async {
  return ref.read(_balanceRepositoryProvider).getBalance(
        address,
        tokenAddress,
      );
}

@riverpod
Future<Balance?> _getUserTokensBalance(
  _GetUserTokensBalanceRef ref,
  String address,
) async {
  return ref.read(_balanceRepositoryProvider).getUserTokensBalance(
        address,
      );
}

abstract class BalanceProviders {
  static const getBalance = _getBalanceProvider;
  static final balanceRepository = _balanceRepositoryProvider;
  static const getUserTokensBalance = _getUserTokensBalanceProvider;
}
