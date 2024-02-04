/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiatValue {
  Future<String> display(
    WidgetRef ref,
    DexToken token,
    double amount, {
    bool withParenthesis = true,
    int precision = 2,
  }) async {
    final price = ref.watch(DexTokensProviders.estimateTokenInFiat(token));

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
