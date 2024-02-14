/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddSheet extends ConsumerStatefulWidget {
  const PoolAddSheet({
    this.token1,
    this.token2,
    super.key,
  });

  final DexToken? token1;
  final DexToken? token2;

  static const routerPage = '/poolAdd';

  @override
  ConsumerState<PoolAddSheet> createState() => _PoolAddSheetState();
}

class _PoolAddSheetState extends ConsumerState<PoolAddSheet> {
  @override
  void initState() {
    if (widget.token1 != null && widget.token2 != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(PoolAddFormProvider.poolAddForm.notifier)
          ..setToken1(widget.token1!)
          ..setToken2(widget.token2!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
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
                          if (poolAdd.poolAddProcessStep ==
                              PoolAddProcessStep.form)
                            const PoolAddFormSheet()
                          else
                            const PoolAddConfirmSheet(),
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
