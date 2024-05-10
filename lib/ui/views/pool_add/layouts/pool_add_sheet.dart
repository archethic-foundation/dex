/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_form_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolAddSheet extends ConsumerStatefulWidget {
  const PoolAddSheet({
    this.token1,
    this.token2,
    required this.poolsListTab,
    super.key,
  });

  final DexToken? token1;
  final DexToken? token2;
  final PoolsListTab poolsListTab;

  static const routerPage = '/poolAdd';

  @override
  ConsumerState<PoolAddSheet> createState() => _PoolAddSheetState();
}

class _PoolAddSheetState extends ConsumerState<PoolAddSheet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref
          .read(PoolAddFormProvider.poolAddForm.notifier)
          .setPoolsListTab(widget.poolsListTab);
      if (widget.token1 != null && widget.token2 != null) {
        try {
          ref.read(navigationIndexMainScreenProvider.notifier).state =
              NavigationIndex.pool;

          if (context.mounted) {
            await ref
                .read(PoolAddFormProvider.poolAddForm.notifier)
                .setToken1(widget.token1!, context);
          }
          if (context.mounted) {
            await ref
                .read(PoolAddFormProvider.poolAddForm.notifier)
                // ignore: use_build_context_synchronously
                .setToken2(widget.token2!, context);
          }
        } catch (e) {
          if (mounted) {
            context.go(
              Uri(
                path: PoolListSheet.routerPage,
                queryParameters: {
                  'tab': widget.poolsListTab,
                },
              ).toString(),
            );
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(PoolAddFormProvider.poolAddForm).processStep,
      formSheet: const PoolAddFormSheet(),
      confirmSheet: const PoolAddConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
