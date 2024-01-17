// ignore_for_file: avoid_redundant_argument_values

import 'dart:convert';

import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/repositories/market.repository.dart';
import 'package:http/http.dart' as http;

class MarketRepositoryImpl implements MarketRepository {
  @override
  Future<Result<double, Failure>> getPrice(
    int ucid,
  ) async =>
      Result.guard(
        () async {
          double? price;
          final url =
              'https://fas.archethic.net/api/v1/quotes/latest?ucids=$ucid';
          final headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };

          try {
            final response = await http.get(Uri.parse(url), headers: headers);
            if (response.statusCode == 200) {
              final jsonData =
                  json.decode(response.body) as Map<String, dynamic>;
              if (jsonData['$ucid'] != null) {
                price = jsonData['$ucid'] as double;
              }
            }
            // ignore: unused_catch_stack
          } catch (e, stacktrace) {
            /*  sl.get<LogManager>().log(
            e.toString(),
            stackTrace: stacktrace,
            level: LogLevel.error,
            name: 'CoinPriceNotifier - _fetchPrices',
          );*/
          }

          if (price == null) throw const Failure.invalidValue();
          return price;
        },
      );
}
