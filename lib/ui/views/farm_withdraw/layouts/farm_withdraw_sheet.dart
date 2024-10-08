/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_list/layouts/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmWithdrawSheet extends ConsumerStatefulWidget {
  const FarmWithdrawSheet({
    required this.farmAddress,
    required this.poolAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;

  static const routerPage = '/farmWithdraw';

  @override
  ConsumerState<FarmWithdrawSheet> createState() => _FarmWithdrawSheetState();
}

class _FarmWithdrawSheetState extends ConsumerState<FarmWithdrawSheet> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        ref.read(farmWithdrawFormNotifierProvider.notifier)
          ..setFarmAddress(widget.farmAddress)
          ..setRewardToken(widget.rewardToken)
          ..setLpTokenAddress(widget.lpTokenAddress);

        final farmInfo = await ref.read(
          DexFarmProviders.getFarmInfos(
            widget.farmAddress,
            widget.poolAddress,
            dexFarmInput: DexFarm(
              poolAddress: widget.poolAddress,
              farmAddress: widget.farmAddress,
            ),
          ).future,
        );

        if (farmInfo == null) {
          if (mounted) {
            context.go(FarmListSheet.routerPage);
          }
        } else {
          ref.read(farmWithdrawFormNotifierProvider.notifier)
            ..setDexFarmInfo(farmInfo)
            ..setRewardAmount(farmInfo.rewardAmount)
            ..setDepositedAmount(farmInfo.depositedAmount);
        }

        final session = ref.read(sessionNotifierProvider);
        if (session.genesisAddress.isEmpty) {
          if (mounted) {
            context.pop();
          }
        }
      } catch (e) {
        if (mounted) {
          context.pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(farmWithdrawFormNotifierProvider).processStep,
      formSheet: const FarmWithdrawFormSheet(),
      confirmSheet: const FarmWithdrawConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
