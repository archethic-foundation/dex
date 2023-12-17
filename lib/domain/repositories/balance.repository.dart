import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;

abstract class BalanceRepository {
  Future<double> getBalance(
    String address,
    String tokenAddress,
  );

  Future<Balance?> getUserTokensBalance(
    String address,
  );
}
