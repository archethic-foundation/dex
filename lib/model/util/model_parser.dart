import 'package:aedex/model/dex_token.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

mixin ModelParser {
  Token tokenModelToSDK(
    DexToken token,
  ) {
    return Token(
      name: token.name,
      genesis: token.genesisAddress,
      symbol: token.symbol,
    );
  }

  DexToken tokenSDKToModel(
    Token token,
  ) {
    return DexToken(
      name: token.name ?? '',
      genesisAddress: token.genesis ?? '',
      symbol: token.symbol ?? '',
    );
  }
}
