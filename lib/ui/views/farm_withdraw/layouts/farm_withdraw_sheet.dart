/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
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
    return MainScreen(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
  return Align(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 650,
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.sheetBackground,
            border: Border.all(
              color: aedappfm.AppThemeBase.sheetBorder,
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
                return aedappfm.ArchethicScrollbar(
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
      ),
    ),
  );
}
