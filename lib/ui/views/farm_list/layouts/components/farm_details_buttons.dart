import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmDetailsButtons extends ConsumerWidget {
  const FarmDetailsButtons({
    super.key,
    required this.farm,
    required this.rewardAmount,
    required this.depositedAmount,
    required this.userBalance,
    this.isInPopup = false,
  });

  final DexFarm farm;
  final double? rewardAmount;
  final double? depositedAmount;
  final double? userBalance;
  final bool? isInPopup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isInPopup == true) {
      return Column(
        children: [
          _closeButton(context),
        ],
      );
    }

    return Column(
      children: [
        if (aedappfm.Responsive.isDesktop(context) ||
            aedappfm.Responsive.isTablet(context))
          Column(
            children: [
              _depositButton(context, ref, userBalance),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: _widthdrawButton(context, ref),
                  ),
                  Expanded(
                    child: _claimButton(context, ref),
                  ),
                ],
              ),
            ],
          )
        else
          Column(
            children: [
              _depositButton(context, ref, userBalance),
              const SizedBox(
                height: 10,
              ),
              _widthdrawButton(context, ref),
              const SizedBox(
                height: 10,
              ),
              _claimButton(context, ref),
            ],
          ),
      ],
    );
  }

  Widget _depositButton(
    BuildContext context,
    WidgetRef ref,
    double? userBalance,
  ) {
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    return farm.endDate != null && farm.endDate!.isBefore(DateTime.now())
        ? ButtonValidateMobile(
            labelBtn: AppLocalizations.of(context)!
                .farmDetailsButtonDepositFarmClosed,
            onPressed: () {},
            controlOk: false,
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
        : ButtonValidateMobile(
            controlOk: userBalance != null && userBalance > 0,
            labelBtn: AppLocalizations.of(context)!.farmDetailsButtonDeposit,
            onPressed: () {
              final farmAddressJson = jsonEncode(farm.farmAddress);
              final farmAddressEncoded = Uri.encodeComponent(farmAddressJson);

              final lpTokenAddressJson = jsonEncode(farm.lpToken!.address);
              final lpTokenAddressEncoded =
                  Uri.encodeComponent(lpTokenAddressJson);

              final poolAddressJson = jsonEncode(farm.poolAddress);
              final poolAddressEncoded = Uri.encodeComponent(poolAddressJson);

              context.go(
                Uri(
                  path: FarmDepositSheet.routerPage,
                  queryParameters: {
                    'farmAddress': farmAddressEncoded,
                    'lpTokenAddress': lpTokenAddressEncoded,
                    'poolAddress': poolAddressEncoded,
                  },
                ).toString(),
              );
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
          );
  }

  Widget _widthdrawButton(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    return ButtonValidateMobile(
      controlOk: depositedAmount != null && depositedAmount! > 0,
      labelBtn: AppLocalizations.of(context)!.farmDetailsButtonWithdraw,
      onPressed: () {
        final farmAddressJson = jsonEncode(farm.farmAddress);
        final farmAddressEncoded = Uri.encodeComponent(farmAddressJson);

        final rewardTokenJson = jsonEncode(farm.rewardToken);
        final rewardTokenEncoded = Uri.encodeComponent(rewardTokenJson);

        final lpTokenAddressJson = jsonEncode(farm.lpToken!.address);
        final lpTokenAddressEncoded = Uri.encodeComponent(lpTokenAddressJson);

        final poolAddressJson = jsonEncode(farm.poolAddress);
        final poolAddressEncoded = Uri.encodeComponent(poolAddressJson);

        context.push(
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
      },
      isConnected: session.isConnected,
      displayWalletConnectOnPressed: () async {
        final session =
            ref.read(sessionNotifierProvider).value ?? const Session();
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
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

  Widget _claimButton(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    return ButtonValidateMobile(
      controlOk: rewardAmount != null && rewardAmount! > 0,
      labelBtn: AppLocalizations.of(context)!.farmDetailsButtonClaim,
      onPressed: () async {
        if (context.mounted) {
          await context.push(
            Uri(
              path: FarmClaimSheet.routerPage,
              queryParameters: {
                'farmAddress': farm.farmAddress.encodeParam(),
                'rewardToken': farm.rewardToken.encodeParam(),
                'lpTokenAddress': farm.lpToken!.address.encodeParam(),
                'rewardAmount': farm.rewardAmount.encodeParam(),
              },
            ).toString(),
          );
        }
      },
      isConnected: session.isConnected,
      displayWalletConnectOnPressed: () async {
        final session =
            ref.read(sessionNotifierProvider).value ?? const Session();
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
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

  Widget _closeButton(BuildContext context) {
    return aedappfm.AppButton(
      backgroundGradient: LinearGradient(
        colors: [
          aedappfm.ArchethicThemeBase.blue400,
          aedappfm.ArchethicThemeBase.blue600,
        ],
      ),
      labelBtn: AppLocalizations.of(context)!.btn_close,
      onPressed: () async {
        context.pop();
      },
    );
  }
}
