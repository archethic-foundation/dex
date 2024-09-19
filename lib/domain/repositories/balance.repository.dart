import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

abstract class BalanceRepository {
  Future<double> getBalance(
    String? address,
    String tokenAddress,
  );

  Future<archethic.Balance?> getUserTokensBalance(
    String address,
  );
}
