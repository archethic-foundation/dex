import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/farm_lock_sheet.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/farm_lock_level_up_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnLevelUp extends ConsumerWidget {
  const FarmLockBtnLevelUp({
    required this.farmAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.lpTokenAmount,
    required this.depositIndex,
    required this.currentLevel,
    required this.rewardAmount,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double lpTokenAmount;
  final int depositIndex;
  final String currentLevel;
  final bool enabled;
  final double rewardAmount;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);
    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false
                ? null
                : () async {
                    if (context.mounted) {
                      final poolJson = jsonEncode(farmLockForm.pool!.toJson());
                      final poolEncoded = Uri.encodeComponent(poolJson);
                      final farmLockJson =
                          jsonEncode(farmLockForm.farmLock!.toJson());
                      final farmLockEncoded = Uri.encodeComponent(farmLockJson);
                      final depositIndexJson = jsonEncode(depositIndex);
                      final depositIndexEncoded = Uri.encodeComponent(
                        depositIndexJson,
                      );
                      final currentLevelJson = jsonEncode(currentLevel);
                      final currentLevelEncoded = Uri.encodeComponent(
                        currentLevelJson,
                      );
                      final lpAmountJson = jsonEncode(lpTokenAmount);
                      final lpAmountEncoded = Uri.encodeComponent(
                        lpAmountJson,
                      );
                      final rewardAmountJson = jsonEncode(rewardAmount);
                      final rewardAmountEncoded = Uri.encodeComponent(
                        rewardAmountJson,
                      );

                      await context.push(
                        Uri(
                          path: FarmLockLevelUpSheet.routerPage,
                          queryParameters: {
                            'pool': poolEncoded,
                            'farmLock': farmLockEncoded,
                            'depositIndex': depositIndexEncoded,
                            'currentLevel': currentLevelEncoded,
                            'lpAmount': lpAmountEncoded,
                            'rewardAmount': rewardAmountEncoded,
                          },
                        ).toString(),
                      );
                      if (context.mounted) {
                        {
                          await context
                              .findAncestorStateOfType<FarmLockSheetState>()
                              ?.loadInfo();
                        }
                      }
                    }
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
                  child: Icon(
                    Icons.keyboard_double_arrow_up,
                    color:
                        enabled ? Colors.white : Colors.white.withOpacity(0.5),
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
                    color:
                        enabled ? Colors.white : Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          )
        : aedappfm.ButtonValidate(
            controlOk: enabled,
            labelBtn: AppLocalizations.of(context)!.farmLockBtnLevelUp,
            onPressed: () async {
              if (context.mounted) {
                final poolJson = jsonEncode(farmLockForm.pool!.toJson());
                final poolEncoded = Uri.encodeComponent(poolJson);
                final farmLockJson =
                    jsonEncode(farmLockForm.farmLock!.toJson());
                final farmLockEncoded = Uri.encodeComponent(farmLockJson);
                final depositIndexJson = jsonEncode(depositIndex);
                final depositIndexEncoded = Uri.encodeComponent(
                  depositIndexJson,
                );
                final currentLevelJson = jsonEncode(currentLevel);
                final currentLevelEncoded = Uri.encodeComponent(
                  currentLevelJson,
                );
                final lpAmountJson = jsonEncode(lpTokenAmount);
                final lpAmountEncoded = Uri.encodeComponent(
                  lpAmountJson,
                );
                final rewardAmountJson = jsonEncode(rewardAmount);
                final rewardAmountEncoded = Uri.encodeComponent(
                  rewardAmountJson,
                );

                await context.push(
                  Uri(
                    path: FarmLockLevelUpSheet.routerPage,
                    queryParameters: {
                      'pool': poolEncoded,
                      'farmLock': farmLockEncoded,
                      'depositIndex': depositIndexEncoded,
                      'currentLevel': currentLevelEncoded,
                      'lpAmount': lpAmountEncoded,
                      'rewardAmount': rewardAmountEncoded,
                    },
                  ).toString(),
                );
                if (context.mounted) {
                  {
                    await context
                        .findAncestorStateOfType<FarmLockSheetState>()
                        ?.loadInfo();
                  }
                }
              }
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
          );
  }
}
