/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimSheet extends ConsumerStatefulWidget {
  const FarmClaimSheet({
    required this.farm,
    required this.farmUserInfo,
    super.key,
  });

  final DexFarmUserInfos farmUserInfo;
  final DexFarm farm;

  static const routerPage = '/farmClaim';

  @override
  ConsumerState<FarmClaimSheet> createState() => _FarmClaimSheetState();
}

class _FarmClaimSheetState extends ConsumerState<FarmClaimSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(FarmClaimFormProvider.farmClaimForm.notifier)
        ..setDexFarm(widget.farm)
        ..setDexFarmUserInfo(widget.farmUserInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(FarmClaimFormProvider.farmClaimForm).processStep,
      formSheet: const FarmClaimFormSheet(),
      confirmSheet: const FarmClaimConfirmSheet(),
      bottomWidget: const aedappfm.ArchethicOracleUco(),
    );
  }
}
