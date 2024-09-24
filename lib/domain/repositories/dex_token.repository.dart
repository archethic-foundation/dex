import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

abstract class DexTokenRepository {
  Future<DexToken?> getTokenFromCache(
    String address,
  );

  Future<List<DexToken>> getTokens(
    archethic.Balance balance,
  );

  Future<List<DexToken>> getLocalTokensDescriptions();
}
