import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  @override
  Future<double> getBalance(
    String address,
    String tokenAddress,
  ) async {
    final balanceGetResponseMap =
        await sl.get<ApiService>().fetchBalance([address]);
    if (balanceGetResponseMap[address] == null) {
      return 0.0;
    }
    final balanceGetResponse = balanceGetResponseMap[address];
    for (final balanceToken in balanceGetResponse!.token) {
      if (balanceToken.address!.toUpperCase() == tokenAddress.toUpperCase()) {
        return fromBigInt(balanceToken.amount).toDouble();
      }
    }

    return 0.0;
  }
}
