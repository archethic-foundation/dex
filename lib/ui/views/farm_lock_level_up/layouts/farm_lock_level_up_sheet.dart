import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockLevelUpSheet extends ConsumerStatefulWidget {
  const FarmLockLevelUpSheet({
    required this.pool,
    required this.farmLock,
    required this.depositId,
    required this.currentLevel,
    required this.lpAmount,
    required this.rewardAmount,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock farmLock;
  final String depositId;
  final String currentLevel;
  final double lpAmount;
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
        ref.read(navigationIndexMainScreenProvider.notifier).state =
            NavigationIndex.earn;

        ref.read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier)
          ..setDexPool(widget.pool)
          ..setDexFarmLock(widget.farmLock)
          ..setDepositId(widget.depositId)
          ..setAmount(widget.lpAmount)
          ..setLevel(widget.farmLock.availableLevels.entries.last.key)
          ..setCurrentLevel(widget.currentLevel)
          ..setAPREstimation(widget.farmLock.apr3years * 100);

        await ref
            .read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier)
            .initBalances();

        ref
            .read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier)
            .filterAvailableLevels();
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
        rewardAmount: widget.rewardAmount,
      ),
      confirmSheet: const FarmLockLevelUpConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
