import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';

abstract class MarketRepository {
  Future<Result<double, Failure>> getPrice(
    int ucid,
  );
}
