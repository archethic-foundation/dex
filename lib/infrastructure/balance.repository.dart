import 'package:aedex/domain/repositories/balance.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show Balance, ApiService, fromBigInt;

class BalanceRepositoryImpl implements BalanceRepository {
  @override
  Future<double> getBalance(
    String address,
    String tokenAddress,
  ) async {
    final balanceGetResponseMap =
        await aedappfm.sl.get<ApiService>().fetchBalance([address]);
    if (balanceGetResponseMap[address] == null) {
      return 0.0;
    }
    final balanceGetResponse = balanceGetResponseMap[address];

    if (tokenAddress == 'UCO') {
      return fromBigInt(balanceGetResponse!.uco).toDouble();
    }
    for (final balanceToken in balanceGetResponse!.token) {
      if (balanceToken.address!.toUpperCase() == tokenAddress.toUpperCase()) {
        return fromBigInt(balanceToken.amount).toDouble();
      }
    }

    return 0.0;
  }

  @override
  Future<Balance?> getUserTokensBalance(
    String address,
  ) async {
    final balanceGetResponseMap =
        await aedappfm.sl.get<ApiService>().fetchBalance([address]);
    if (balanceGetResponseMap[address] != null) {
      return balanceGetResponseMap[address];
    }
    return null;
  }
}
