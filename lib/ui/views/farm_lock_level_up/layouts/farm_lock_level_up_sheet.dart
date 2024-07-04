/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockLevelUpSheet extends ConsumerStatefulWidget {
  const FarmLockLevelUpSheet({
    required this.pool,
    required this.farmLock,
    required this.depositIndex,
    required this.currentLevel,
    required this.lpAmount,
    required this.timestampStart,
    required this.rewardAmount,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock farmLock;
  final int depositIndex;
  final String currentLevel;
  final double lpAmount;
  final int timestampStart;
  final double rewardAmount;

  static const routerPage = '/farmLockLevelUp';

  @override
  ConsumerState<FarmLockLevelUpSheet> createState() =>
      _FarmLockLevelUpSheetState();
}

class _FarmLockLevelUpSheetState extends ConsumerState<FarmLockLevelUpSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

        ref.read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier)
          ..setDexPool(widget.pool)
          ..setDexFarmLock(widget.farmLock)
          ..setDepositIndex(widget.depositIndex)
          ..setAmount(widget.lpAmount)
          ..setAPREstimation(widget.farmLock.apr3years);

        await ref
            .read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier)
            .initBalances();
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
      currentStep: ref
          .watch(FarmLockLevelUpFormProvider.farmLockLevelUpForm)
          .processStep,
      formSheet: FarmLockLevelUpFormSheet(
        currentLevel: widget.currentLevel,
        timestampStart: widget.timestampStart,
        rewardAmount: widget.rewardAmount,
      ),
      confirmSheet: const FarmLockLevelUpConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}