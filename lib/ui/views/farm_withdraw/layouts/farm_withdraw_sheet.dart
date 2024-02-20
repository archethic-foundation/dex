/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.farm;

      ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier)
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
        ref
            .read(FarmWithdrawFormProvider.farmWithdrawForm.notifier)
            .setDexFarmInfo(farmInfo);
      }

      final session = ref.read(SessionProviders.session);
      if (session.genesisAddress.isEmpty) {
        if (mounted) {
          context.go(FarmListSheet.routerPage);
        }
      }

      final farmUserInfo = await ref.read(
        DexFarmProviders.getUserInfos(
          widget.farmAddress,
          session.genesisAddress,
        ).future,
      );
      if (farmUserInfo == null) {
        if (mounted) {
          context.go(FarmListSheet.routerPage);
        }
      } else {
        ref
            .read(FarmWithdrawFormProvider.farmWithdrawForm.notifier)
            .setDexFarmUserInfo(farmUserInfo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep:
          ref.watch(FarmWithdrawFormProvider.farmWithdrawForm).processStep,
      formSheet: const FarmWithdrawFormSheet(),
      confirmSheet: const FarmWithdrawConfirmSheet(),
      bottomWidget: const aedappfm.ArchethicOracleUco(),
    );
  }
}
