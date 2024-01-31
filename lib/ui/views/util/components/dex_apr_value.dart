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
    int endDate,
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
    return lpTokenDepositedInFiatResult.map(
      data: (data) {
        final now =
            (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).truncate();

        if (remainingRewardInFiat > 0 && data.value > 0 && now < endDate) {
          // 31 536 000 second in a year
          final rewardScalledToYear =
              remainingRewardInFiat * (31536000 / (endDate - now));

          final apr = (Decimal.parse('$rewardScalledToYear') /
                  Decimal.parse('${data.value}'))
              .toDouble();

          return '${(apr * 100).formatNumber(precision: 4)}%';
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
