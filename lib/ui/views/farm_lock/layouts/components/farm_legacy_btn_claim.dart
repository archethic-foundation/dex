import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLegacyBtnClaim extends ConsumerWidget {
  const FarmLegacyBtnClaim({
    this.enabled = true,
    super.key,
  });

  final bool enabled;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider);
    final farm = ref.watch(farmLockFormFarmProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;
    final isLoading = farm == null || pool == null;

    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false || isLoading
                ? null
                : () => _validate(context, farm, pool),
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
                          aedappfm.Iconsax.export_2,
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
                  AppLocalizations.of(context)!.farmDetailsButtonClaim,
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
                .fade(duration: const Duration(milliseconds: 400))
                .scale(duration: const Duration(milliseconds: 400)),
          )
        : ButtonValidateMobile(
            controlOk: enabled,
            labelBtn: AppLocalizations.of(context)!.farmDetailsButtonClaim,
            onPressed: () {
              if (isLoading) return;
              _validate(context, farm, pool);
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
            .fade(duration: const Duration(milliseconds: 400))
            .scale(duration: const Duration(milliseconds: 400));
  }

  Future<void> _validate(
    BuildContext context,
    DexFarm farm,
    DexPool pool,
  ) async {
    if (!context.mounted) return;
    await context.push(
      Uri(
        path: FarmClaimSheet.routerPage,
        queryParameters: {
          'farmAddress': farm.farmAddress.encodeParam(),
          'rewardToken': farm.rewardToken.encodeParam(),
          'poolAddress': farm.poolAddress.encodeParam(),
          'lpTokenAddress': pool.lpToken.address.encodeParam(),
          'rewardAmount': farm.rewardAmount.encodeParam(),
        },
      ).toString(),
    );
  }
}
