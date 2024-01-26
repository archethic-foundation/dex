import 'package:aedex/application/market.dart';
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
      final price =
          await ref.watch(MarketProviders.getPriceFromSymbol(symbol).future);
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
