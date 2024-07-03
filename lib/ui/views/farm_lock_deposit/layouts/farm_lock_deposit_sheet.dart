/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
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
        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

        ref.read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
          ..setDexPool(widget.pool)
          ..setDexFarmLock(widget.farmLock)
          ..setAPREstimation(widget.farmLock.apr3years);

        await ref
            .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
            .initBalances();
      } catch (e) {
        if (mounted) {
          context.go(PoolListSheet.routerPage);
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
