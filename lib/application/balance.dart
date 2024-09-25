import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
Future<archethic.Balance> userBalance(UserBalanceRef ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final genesisAddress = ref.watch(
    sessionNotifierProvider.select((session) => session.genesisAddress),
  );

  if (genesisAddress.isEmpty) return const archethic.Balance();

  return await BalanceRepositoryImpl(
        apiService: apiService,
      ).getUserTokensBalance(
        genesisAddress,
      ) ??
      const archethic.Balance();
}

@riverpod
Future<double> getBalance(
  GetBalanceRef ref,
  String tokenAddress,
) async {
  final userBalance = await ref.watch(userBalanceProvider.future);
  if (tokenAddress == 'UCO') {
    return archethic.fromBigInt(userBalance.uco).toDouble();
  }

  final tokenAmount = userBalance.token
          .firstWhereOrNull(
            (token) =>
                token.address!.toUpperCase() == tokenAddress.toUpperCase(),
          )
          ?.amount ??
      0;

  return archethic.fromBigInt(tokenAmount).toDouble();
}
