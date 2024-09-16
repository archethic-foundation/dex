import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositSheet extends ConsumerStatefulWidget {
  const FarmLockDepositSheet({
    required this.pool,
    required this.farmLock,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock farmLock;

  static const routerPage = '/farmLockDeposit';

  @override
  ConsumerState<FarmLockDepositSheet> createState() =>
      _FarmLockDepositSheetState();
}

class _FarmLockDepositSheetState extends ConsumerState<FarmLockDepositSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        ref.read(navigationIndexMainScreenProvider.notifier).state =
            NavigationIndex.earn;

        ref.read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
          ..setDexPool(widget.pool)
          ..setDexFarmLock(widget.farmLock)
          ..setLevel(widget.farmLock.availableLevels.entries.last.key)
          ..setAPREstimation(widget.farmLock.apr3years * 100);

        await ref
            .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
            .initBalances();

        ref
            .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
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
          .watch(FarmLockDepositFormProvider.farmLockDepositForm)
          .processStep,
      formSheet: const FarmLockDepositFormSheet(),
      confirmSheet: const FarmLockDepositConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
