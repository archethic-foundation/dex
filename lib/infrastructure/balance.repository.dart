import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class BalanceRepositoryImpl implements BalanceRepository {
  BalanceRepositoryImpl({required this.apiService});

  final archethic.ApiService apiService;
  @override
  Future<double> getBalance(
    String? address,
    String tokenAddress,
  ) async {
    if (address == null) return 0.0;
    final balanceGetResponseMap = await apiService.fetchBalance([address]);
    if (balanceGetResponseMap[address] == null) {
      return 0.0;
    }
    final balanceGetResponse = balanceGetResponseMap[address];

    if (tokenAddress == 'UCO') {
      return archethic.fromBigInt(balanceGetResponse!.uco).toDouble();
    }
    for (final balanceToken in balanceGetResponse!.token) {
      if (balanceToken.address!.toUpperCase() == tokenAddress.toUpperCase()) {
        return archethic.fromBigInt(balanceToken.amount).toDouble();
      }
    }

    return 0.0;
  }

  @override
  Future<archethic.Balance?> getUserTokensBalance(
    String address,
  ) async {
    final balanceGetResponseMap = await apiService.fetchBalance([address]);
    if (balanceGetResponseMap[address] != null) {
      return balanceGetResponseMap[address];
    }
    return null;
  }
}
