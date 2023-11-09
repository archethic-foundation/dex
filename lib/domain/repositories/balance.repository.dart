abstract class BalanceRepository {
  Future<double> getBalance(
    String address,
    String tokenAddress,
  );
}
