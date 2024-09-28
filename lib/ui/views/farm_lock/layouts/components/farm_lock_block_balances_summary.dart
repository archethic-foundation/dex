import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockBalanceSummary extends ConsumerWidget {
  const FarmLockBlockBalanceSummary({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final balances = ref.watch(farmLockFormBalancesProvider);
    final pool = ref.watch(farmLockFormPoolProvider).value;

    return BlockInfo(
      info: (pool == null)
          ? const SizedBox.shrink()
          : Column(
              children: [
                Row(
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .farmLockBlockBalanceSummaryHeader,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: aedappfm.AppThemeBase.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    DexTokenBalance(
                      tokenBalance: balances.token1Balance,
                      token: pool.pair.token1,
                      digits: balances.token1Balance < 1 ? 8 : 2,
                      pool: pool,
                      fiatTextStyleMedium: true,
                      styleResponsive: false,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DexTokenBalance(
                      tokenBalance: balances.token2Balance,
                      token: pool.pair.token2,
                      digits: balances.token2Balance < 1 ? 8 : 2,
                      pool: pool,
                      fiatTextStyleMedium: true,
                      styleResponsive: false,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DexTokenBalance(
                      tokenBalance: balances.lpTokenBalance,
                      token: pool.lpToken,
                      digits: balances.lpTokenBalance < 1 ? 8 : 2,
                      pool: pool,
                      fiatTextStyleMedium: true,
                      styleResponsive: false,
                    ),
                  ],
                ),
              ],
            ),
      height: height,
      width: width,
    );
  }
}
