import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/layouts/farm_lock_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLegacyBtnWithdraw extends ConsumerWidget {
  const FarmLegacyBtnWithdraw({
    required this.farmAddress,
    required this.poolAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.rewardAmount,
    required this.currentSortedColumn,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double rewardAmount;
  final bool enabled;
  final String currentSortedColumn;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);

    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false || farmLockForm.mainInfoloadingInProgress
                ? null
                : () async {
                    await _validate(context);
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
                  AppLocalizations.of(context)!
                      .aeswap_farmDetailsButtonWithdraw,
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
                .fade(duration: const Duration(milliseconds: 300))
                .scale(duration: const Duration(milliseconds: 300)),
          )
        : ButtonValidateMobile(
            controlOk: enabled,
            labelBtn:
                AppLocalizations.of(context)!.aeswap_farmDetailsButtonWithdraw,
            onPressed: () async {
              await _validate(context);
            },
            displayWalletConnect: true,
            isConnected: session.isConnected,
            displayWalletConnectOnPressed: () async {
              final sessionNotifier =
                  ref.read(SessionProviders.session.notifier);
              await sessionNotifier.connectToWallet();

              final session = ref.read(SessionProviders.session);
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

  Future<void> _validate(BuildContext context) async {
    if (context.mounted) {
      await context.push(
        Uri(
          path: FarmWithdrawSheet.routerPage,
          queryParameters: {
            'farmAddress': farmAddress.encodeParam(),
            'rewardToken': rewardToken.encodeParam(),
            'lpTokenAddress': lpTokenAddress.encodeParam(),
            'poolAddress': poolAddress.encodeParam(),
          },
        ).toString(),
      );
      if (context.mounted) {
        {
          await context
              .findAncestorStateOfType<FarmLockSheetState>()
              ?.loadInfo(sortCriteria: currentSortedColumn);
        }
      }
    }
  }
}
