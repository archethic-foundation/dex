/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class FarmWithdrawSheet extends ConsumerStatefulWidget {
  const FarmWithdrawSheet({
    required this.farm,
    super.key,
  });

  final DexFarm farm;
  @override
  ConsumerState<FarmWithdrawSheet> createState() => _FarmWithdrawSheetState();
}

class _FarmWithdrawSheetState extends ConsumerState<FarmWithdrawSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier)
        ..setDexFarmInfos(widget.farm)
        ..initBalances();
    });
  }

  @override
  Widget build(BuildContext context) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    return Align(
      child: Container(
        width: 650,
        decoration: BoxDecoration(
          gradient: DexThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: DexThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background-sheet.png',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 40,
              spreadRadius: 10,
              offset: const Offset(1, 10),
            ),
          ],
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
                        if (farmWithdraw.farmWithdrawProcessStep ==
                            FarmWithdrawProcessStep.form)
                          const FarmWithdrawFormSheet()
                        else
                          const FarmWithdrawConfirmSheet(),
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
    );
  }
}
