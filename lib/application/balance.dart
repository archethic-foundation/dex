import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@Riverpod(keepAlive: true)
BalanceRepository _balanceRepository(_BalanceRepositoryRef ref) =>
    BalanceRepositoryImpl(
      apiService: ref.watch(apiServiceProvider),
    );

@Riverpod(keepAlive: true)
Future<Balance> userBalance(UserBalanceRef ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final genesisAddress = ref.watch(
    sessionNotifierProvider.select((session) => session.genesisAddress),
  );

  if (genesisAddress.isEmpty) return const Balance();

  return await BalanceRepositoryImpl(
        apiService: apiService,
      ).getUserTokensBalance(
        genesisAddress,
      ) ??
      const Balance();
}

@Riverpod(keepAlive: true)
Future<double> getBalance(
  GetBalanceRef ref,
  String tokenAddress,
) async {
  final address = ref.watch(sessionNotifierProvider).genesisAddress;
  return ref.watch(_balanceRepositoryProvider).getBalance(
        address,
        tokenAddress,
      );
}
