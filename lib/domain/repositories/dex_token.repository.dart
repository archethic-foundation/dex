import 'package:aedex/domain/models/dex_token.dart';

abstract class DexTokenRepository {
  Future<DexToken?> getTokenFromAddress(
    String address,
  );

  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  );

  Future<List<DexToken>> getLocalTokensDescriptions();
}
