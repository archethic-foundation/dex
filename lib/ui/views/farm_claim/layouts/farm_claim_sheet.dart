/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/bloc/state.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
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
    return MainScreen(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
  return Align(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 650,
          decoration: BoxDecoration(
            color: DexThemeBase.sheetBackground,
            border: Border.all(
              color: DexThemeBase.sheetBorder,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 11,
              bottom: 5,
            ),
            child: LayoutBuilder(
              builder: (context, constraint) {
                return ArchethicScrollbar(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: constraint.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          if (farmClaim.farmClaimProcessStep ==
                              FarmClaimProcessStep.form)
                            const FarmClaimFormSheet()
                          else
                            const FarmClaimConfirmSheet(),
                          const DexArchethicOracleUco(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
