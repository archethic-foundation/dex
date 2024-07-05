import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawSheet extends ConsumerStatefulWidget {
  const FarmLockWithdrawSheet({
    required this.farmAddress,
    required this.poolAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.rewardAmount,
    required this.depositIndex,
    required this.depositedAmount,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final int depositIndex;
  final double rewardAmount;
  final double depositedAmount;

  static const routerPage = '/farmLockWithdraw';

  @override
  ConsumerState<FarmLockWithdrawSheet> createState() =>
      _FarmLockWithdrawSheetState();
}

class _FarmLockWithdrawSheetState extends ConsumerState<FarmLockWithdrawSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        ref.read(navigationIndexMainScreenProvider.notifier).state =
            NavigationIndex.earn;

        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

        ref.read(FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier)
          ..setFarmAddress(widget.farmAddress)
          ..setRewardToken(widget.rewardToken)
          ..setDepositIndex(widget.depositIndex)
          ..setDepositedAmount(widget.depositedAmount)
          ..setRewardAmount(widget.rewardAmount)
          ..setLpTokenAddress(widget.lpTokenAddress);

        final farmLockInfo = await ref.read(
          DexFarmLockProviders.getFarmLockInfos(
            widget.farmAddress,
            widget.poolAddress,
            dexFarmLockInput: DexFarmLock(
              poolAddress: widget.poolAddress,
              farmAddress: widget.farmAddress,
            ),
          ).future,
        );

        if (farmLockInfo == null) {
          if (mounted) {
            context.pop();
          }
        } else {
          ref
              .read(FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier)
              .setDexFarmInfo(farmLockInfo);
        }

        final session = ref.read(SessionProviders.session);
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
      currentStep: ref
          .watch(FarmLockWithdrawFormProvider.farmLockWithdrawForm)
          .processStep,
      formSheet: const FarmLockWithdrawFormSheet(),
      confirmSheet: const FarmLockWithdrawConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
