/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_form_sheet.dart';
import 'package:aedex/ui/views/farm_list/layouts/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmDepositSheet extends ConsumerStatefulWidget {
  const FarmDepositSheet({
    required this.farmAddress,
    required this.poolAddress,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;

  static const routerPage = '/farmDeposit';

  @override
  ConsumerState<FarmDepositSheet> createState() => _FarmDepositSheetState();
}

class _FarmDepositSheetState extends ConsumerState<FarmDepositSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

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
              .read(FarmDepositFormProvider.farmDepositForm.notifier)
              .setDexFarmInfo(farmInfo);
        }

        await ref
            .read(FarmDepositFormProvider.farmDepositForm.notifier)
            .initBalances();
      } catch (e) {
        if (mounted) {
          context.go(FarmListSheet.routerPage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep:
          ref.watch(FarmDepositFormProvider.farmDepositForm).processStep,
      formSheet: const FarmDepositFormSheet(),
      confirmSheet: const FarmDepositConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
