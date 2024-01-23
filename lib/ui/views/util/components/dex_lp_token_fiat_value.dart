import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later
class DEXLPTokenFiatValue {
  Future<String> display(
    WidgetRef ref,
    DexToken token1,
    DexToken token2,
    double lpTokenAmount,
    String poolAddress, {
    bool withParenthesis = true,
  }) async {
    final estimateLPTokenInFiat = ref.watch(
      DexFarmProviders.estimateLPTokenInFiat(
        token1,
        token2,
        lpTokenAmount,
        poolAddress,
      ),
    );

    // ignore: cascade_invocations
    return estimateLPTokenInFiat.map(
      data: (data) {
        if (withParenthesis) {
          return '(\$${data.value.formatNumber(precision: 2)})';
        } else {
          return '\$${data.value.formatNumber(precision: 2)}';
        }
      },
      error: (error) {
        if (withParenthesis) {
          return r'($--)';
        } else {
          return r'$--';
        }
      },
      loading: (loading) {
        if (withParenthesis) {
          return r'($0.00)';
        } else {
          return r'$0.00';
        }
      },
    );
  }
}
