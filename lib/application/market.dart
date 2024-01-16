import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/repositories/market.repository.dart';
import 'package:aedex/infrastructure/market.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market.g.dart';

@riverpod
MarketRepository _marketRepository(_MarketRepositoryRef ref) =>
    MarketRepositoryImpl();

@riverpod
Future<Result<double, Failure>> _getPriceFromCoinId(
  _GetPriceFromCoinIdRef ref,
  int ucid,
) async {
  return ref.read(_marketRepositoryProvider).getPrice(
        ucid,
      );
}

@riverpod
Future<double> _getPriceFromSymbol(
  _GetPriceFromSymbolRef ref,
  String symbol,
) async {
  int? ucid;
  switch (symbol) {
    case 'ETH':
    case 'aeETH':
      ucid = 1027;
      break;
    case 'BNB':
    case 'aeBNB':
      ucid = 1839;
      break;
    case 'MATIC':
    case 'aeMATIC':
      ucid = 3890;
      break;
  }
  if (ucid == null) {
    return 0;
  }
  final result = await ref.read(
    MarketProviders.getPriceFromCoindId(ucid).future,
  );

  return result.map(success: (price) => price, failure: (failure) => 0);
}

abstract class MarketProviders {
  static const getPriceFromCoindId = _getPriceFromCoinIdProvider;
  static final marketRepository = _marketRepositoryProvider;
  static const getPriceFromSymbol = _getPriceFromSymbolProvider;
}
