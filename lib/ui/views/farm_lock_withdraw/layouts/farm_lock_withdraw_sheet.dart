import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pair.dart';
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
    required this.lpToken,
    required this.lpTokenPair,
    required this.rewardAmount,
    required this.depositId,
    required this.depositedAmount,
    required this.endDate,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final DexToken lpToken;
  final DexPair lpTokenPair;
  final String depositId;
  final double rewardAmount;
  final double depositedAmount;
  final DateTime endDate;

  static const routerPage = '/farmLockWithdraw';

  @override
  ConsumerState<FarmLockWithdrawSheet> createState() =>
      _FarmLockWithdrawSheetState();
}

class _FarmLockWithdrawSheetState extends ConsumerState<FarmLockWithdrawSheet> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        ref.read(navigationIndexMainScreenProvider.notifier).state =
            NavigationIndex.earn;
        ref.read(farmLockWithdrawFormNotifierProvider.notifier)
          ..setFarmAddress(widget.farmAddress)
          ..setRewardToken(widget.rewardToken)
          ..setDepositId(widget.depositId)
          ..setDepositedAmount(widget.depositedAmount)
          ..setRewardAmount(widget.rewardAmount)
          ..setEndDate(widget.endDate)
          ..setPoolAddress(widget.poolAddress)
          ..setLPTokenPair(widget.lpTokenPair)
          ..setLpToken(widget.lpToken);

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
      currentStep: ref.watch(farmLockWithdrawFormNotifierProvider).processStep,
      formSheet: const FarmLockWithdrawFormSheet(),
      confirmSheet: const FarmLockWithdrawConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
