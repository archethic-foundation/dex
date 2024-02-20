/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositSheet extends ConsumerStatefulWidget {
  const FarmDepositSheet({
    required this.farm,
    super.key,
  });

  final DexFarm farm;

  static const routerPage = '/farmDeposit';

  @override
  ConsumerState<FarmDepositSheet> createState() => _FarmDepositSheetState();
}

class _FarmDepositSheetState extends ConsumerState<FarmDepositSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.farm;

      ref
          .read(FarmDepositFormProvider.farmDepositForm.notifier)
          .setDexFarmInfo(widget.farm);
      await ref
          .read(FarmDepositFormProvider.farmDepositForm.notifier)
          .initBalances();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep:
          ref.watch(FarmDepositFormProvider.farmDepositForm).processStep,
      formSheet: const FarmDepositFormSheet(),
      confirmSheet: const FarmDepositConfirmSheet(),
      bottomWidget: const aedappfm.ArchethicOracleUco(),
    );
  }
}
