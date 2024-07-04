import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLegacyBtnWithdraw extends ConsumerWidget {
  const FarmLegacyBtnWithdraw({
    required this.farmAddress,
    required this.poolAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.rewardAmount,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double rewardAmount;
  final bool enabled;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);

    return aedappfm.Responsive.isDesktop(context)
        ? InkWell(
            onTap: enabled == false
                ? null
                : () async {
                    if (context.mounted) {
                      final farmAddressJson = jsonEncode(farmAddress);
                      final farmAddressEncoded =
                          Uri.encodeComponent(farmAddressJson);

                      final rewardTokenJson = jsonEncode(rewardToken);
                      final rewardTokenEncoded =
                          Uri.encodeComponent(rewardTokenJson);

                      final lpTokenAddressJson = jsonEncode(lpTokenAddress);
                      final lpTokenAddressEncoded =
                          Uri.encodeComponent(lpTokenAddressJson);

                      final poolAddressJson = jsonEncode(poolAddress);
                      final poolAddressEncoded =
                          Uri.encodeComponent(poolAddressJson);

                      await context.push(
                        Uri(
                          path: FarmWithdrawSheet.routerPage,
                          queryParameters: {
                            'farmAddress': farmAddressEncoded,
                            'rewardToken': rewardTokenEncoded,
                            'lpTokenAddress': lpTokenAddressEncoded,
                            'poolAddress': poolAddressEncoded,
                          },
                        ).toString(),
                      );
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
                    aedappfm.Iconsax.export4,
                    color:
                        enabled ? Colors.white : Colors.white.withOpacity(0.5),
                    size: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.farmDetailsButtonWithdraw,
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
            labelBtn: AppLocalizations.of(context)!.farmDetailsButtonWithdraw,
            onPressed: () async {
              if (context.mounted) {
                final farmAddressJson = jsonEncode(farmAddress);
                final farmAddressEncoded = Uri.encodeComponent(farmAddressJson);

                final rewardTokenJson = jsonEncode(rewardToken);
                final rewardTokenEncoded = Uri.encodeComponent(rewardTokenJson);

                final lpTokenAddressJson = jsonEncode(lpTokenAddress);
                final lpTokenAddressEncoded =
                    Uri.encodeComponent(lpTokenAddressJson);

                final poolAddressJson = jsonEncode(poolAddress);
                final poolAddressEncoded = Uri.encodeComponent(poolAddressJson);

                await context.push(
                  Uri(
                    path: FarmWithdrawSheet.routerPage,
                    queryParameters: {
                      'farmAddress': farmAddressEncoded,
                      'rewardToken': rewardTokenEncoded,
                      'lpTokenAddress': lpTokenAddressEncoded,
                      'poolAddress': poolAddressEncoded,
                    },
                  ).toString(),
                );
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