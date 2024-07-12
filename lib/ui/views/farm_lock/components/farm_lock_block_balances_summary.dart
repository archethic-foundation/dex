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
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);

    return BlockInfo(
      info: Column(
        children: [
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.farmLockBlockBalanceSummaryHeader,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          if (farmLockForm.pool != null)
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: farmLockForm.token1Balance,
                  token: farmLockForm.pool!.pair.token1,
                  digits: farmLockForm.token1Balance < 1 ? 8 : 2,
                  fiatTextStyleMedium: true,
                  styleResponsive: false,
                ),
              ],
            ),
          if (farmLockForm.pool != null)
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: farmLockForm.token2Balance,
                  token: farmLockForm.pool!.pair.token2,
                  digits: farmLockForm.token2Balance < 1 ? 8 : 2,
                  fiatTextStyleMedium: true,
                  styleResponsive: false,
                ),
              ],
            ),
          if (farmLockForm.pool != null)
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: farmLockForm.lpTokenBalance,
                  token: farmLockForm.pool!.lpToken,
                  digits: farmLockForm.lpTokenBalance < 1 ? 8 : 2,
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
