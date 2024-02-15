/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawSheet extends ConsumerStatefulWidget {
  const FarmWithdrawSheet({
    required this.farm,
    super.key,
  });

  final DexFarm farm;

  static const routerPage = '/farmWithdraw';

  @override
  ConsumerState<FarmWithdrawSheet> createState() => _FarmWithdrawSheetState();
}

class _FarmWithdrawSheetState extends ConsumerState<FarmWithdrawSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier)
        ..setDexFarmInfo(widget.farm)
        ..initBalances();
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
