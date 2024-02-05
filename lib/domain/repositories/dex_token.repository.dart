import 'package:aedex/domain/models/dex_token.dart';

abstract class DexTokenRepository {
  Future<List<DexToken>> getTokenFromAddress(
    String address,
  );

  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  );

  Future<String?> getTokenIcon(String address);
}
