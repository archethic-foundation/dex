import 'package:aedex/application/session/provider.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/farm_lock_level_up_sheet.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnLevelUp extends ConsumerWidget {
  const FarmLockBtnLevelUp({
    required this.lpTokenAmount,
    required this.depositId,
    required this.currentLevel,
    required this.rewardAmount,
    this.enabled = true,
    super.key,
  });

  final double lpTokenAmount;
  final String depositId;
  final String currentLevel;
  final bool enabled;
  final double rewardAmount;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider);
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;
    final farm = ref.watch(farmLockFormFarmProvider).value;
    final isLoading = farmLock == null || pool == null || farm == null;

    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false || isLoading
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
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : Icon(
                          Icons.keyboard_double_arrow_up,
                          color: enabled
                              ? Colors.white
                                  .withValues(alpha: AppTextStyles.kOpacityText)
                              : Colors.white.withValues(alpha: 0.5),
                          size: 16,
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.farmLockBtnLevelUp,
                  style: TextStyle(
                    fontSize: 10,
                    color: enabled
                        ? Colors.white
                            .withValues(alpha: AppTextStyles.kOpacityText)
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 300))
                .scale(duration: const Duration(milliseconds: 300)),
          )
        : ButtonValidateMobile(
            controlOk: enabled,
            labelBtn: AppLocalizations.of(context)!.farmLockBtnLevelUp,
            onPressed: () async {
              await _validate(context, ref);
            },
            displayWalletConnect: true,
            isConnected: session.isConnected,
            displayWalletConnectOnPressed: () async {
              final session = ref.read(sessionNotifierProvider);
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
            .fade(duration: const Duration(milliseconds: 300))
            .scale(duration: const Duration(milliseconds: 300));
  }

  Future<void> _validate(BuildContext context, WidgetRef ref) async {
    if (!context.mounted) return;

    final farmLock = ref.read(farmLockFormFarmLockProvider).value;
    final pool = ref.read(farmLockFormPoolProvider).value;
    await context.push(
      Uri(
        path: FarmLockLevelUpSheet.routerPage,
        queryParameters: {
          'pool': pool!.toJson().encodeParam(),
          'farmLock': farmLock!.toJson().encodeParam(),
          'depositId': depositId.encodeParam(),
          'currentLevel': currentLevel.encodeParam(),
          'lpAmount': lpTokenAmount.encodeParam(),
          'rewardAmount': rewardAmount.encodeParam(),
        },
      ).toString(),
    );
  }
}
