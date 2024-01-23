import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later
class DEXAprValue {
  Future<String> display(
    WidgetRef ref,
    String farmGenesisAddress,
    double remainingRewardInFiat,
    DexToken token1,
    DexToken token2,
    double lpTokenDeposited,
    String poolAddress,
  ) async {
    final lpTokenDepositedInFiatResult = ref.watch(
      DexFarmProviders.estimateLPTokenInFiat(
        token1,
        token2,
        lpTokenDeposited,
        poolAddress,
      ),
    );
    var apr = 0.0;
    return lpTokenDepositedInFiatResult.map(
      data: (data) {
        if (remainingRewardInFiat > 0) {
          apr = (Decimal.parse('${data.value}') /
                  Decimal.parse('$remainingRewardInFiat'))
              .toDouble();
          return '${apr.formatNumber(precision: 4)}%';
        }
        return '0%';
      },
      error: (error) {
        return '-%';
      },
      loading: (loading) {
        return '0%';
      },
    );
  }
}
