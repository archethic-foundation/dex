import 'package:aedex/application/coin_price.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later
class FiatValue {
  Future<String> display(
    WidgetRef ref,
    String symbol,
    double amount, {
    bool withParenthesis = true,
    int precision = 2,
  }) async {
    if (symbol == 'UCO') {
      final archethicOracleUCO =
          ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

      final fiatValue = archethicOracleUCO.usd * amount;
      return '(\$${fiatValue.formatNumber(precision: precision)})';
    } else {
      final prices = ref.watch(CoinPriceProviders.coinPrice);
      var price = 0.0;

      switch (symbol) {
        case 'ETH':
        case 'aeETH':
          price = price = prices.ethereum;
          break;
        case 'BNB':
        case 'aeBNB':
          price = price = prices.bsc;
          break;
        case 'MATIC':
        case 'aeMATIC':
          price = price = prices.polygon;
          break;
      }
      if (price == 0) {
        if (withParenthesis) {
          return r'($--)';
        } else {
          return r'$--';
        }
      }
      final fiatValue = price * amount;
      if (withParenthesis) {
        return '(\$${fiatValue.formatNumber(precision: precision)})';
      } else {
        return '\$${fiatValue.formatNumber(precision: precision)}';
      }
    }
  }
}
