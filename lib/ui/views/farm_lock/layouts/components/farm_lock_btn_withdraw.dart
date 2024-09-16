import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/farm_lock_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnWithdraw extends ConsumerWidget {
  const FarmLockBtnWithdraw({
    required this.rewardAmount,
    required this.depositedAmount,
    required this.depositId,
    required this.currentSortedColumn,
    this.enabled = true,
    super.key,
  });

  final double rewardAmount;
  final double depositedAmount;
  final String depositId;
  final bool enabled;
  final String currentSortedColumn;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();

    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false || farmLockForm.mainInfoloadingInProgress
                ? null
                : () async {
                    await _validate(context, ref);
                  },
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: enabled
                        ? aedappfm.AppThemeBase.gradientBtn
                        : aedappfm.AppThemeBase.gradient,
                    shape: BoxShape.circle,
                  ),
                  child: farmLockForm.mainInfoloadingInProgress
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : Icon(
                          aedappfm.Iconsax.export4,
                          color: enabled
                              ? Colors.white
                                  .withOpacity(AppTextStyles.kOpacityText)
                              : Colors.white.withOpacity(0.5),
                          size: 16,
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.farmLockBtnWithdraw,
                  style: TextStyle(
                    fontSize: 10,
                    color: enabled
                        ? Colors.white.withOpacity(AppTextStyles.kOpacityText)
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 350))
                .scale(duration: const Duration(milliseconds: 350)),
          )
        : ButtonValidateMobile(
            controlOk: enabled,
            labelBtn: AppLocalizations.of(context)!.farmLockBtnWithdraw,
            onPressed: () async {
              await _validate(context, ref);
            },
            displayWalletConnect: true,
            isConnected: session.isConnected,
            displayWalletConnectOnPressed: () async {
              final session =
                  ref.read(sessionNotifierProvider).value ?? const Session();
              if (session.error.isNotEmpty) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        Theme.of(context).snackBarTheme.backgroundColor,
                    content: SelectableText(
                      session.error,
                      style: Theme.of(context).snackBarTheme.contentTextStyle,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                if (!context.mounted) return;
                context.go(
                  '/',
                );
              }
            },
          )
            .animate()
            .fade(duration: const Duration(milliseconds: 350))
            .scale(duration: const Duration(milliseconds: 350));
  }

  Future<void> _validate(BuildContext context, WidgetRef ref) async {
    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();

    if (context.mounted) {
      await context.push(
        Uri(
          path: FarmLockWithdrawSheet.routerPage,
          queryParameters: {
            'farmAddress': farmLockForm.farmLock!.farmAddress.encodeParam(),
            'poolAddress': farmLockForm.pool!.poolAddress.encodeParam(),
            'rewardToken': farmLockForm.farmLock!.rewardToken.encodeParam(),
            'lpToken': farmLockForm.pool!.lpToken.encodeParam(),
            'lpTokenPair': farmLockForm.pool!.lpToken.lpTokenPair.encodeParam(),
            'rewardAmount': rewardAmount.encodeParam(),
            'depositedAmount': depositedAmount.encodeParam(),
            'depositId': depositId.encodeParam(),
            'endDate':
                (farmLockForm.farmLock!.endDate!.millisecondsSinceEpoch ~/ 1000)
                    .encodeParam(),
          },
        ).toString(),
      );
    }
  }
}
