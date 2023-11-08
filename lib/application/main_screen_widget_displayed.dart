/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/lp_staking/lp_staking_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidgetDiplayed extends StateNotifier<Widget> {
  MainScreenWidgetDiplayed() : super(const SwapSheet());

  // ignore: use_setters_to_change_properties
  void setWidget(Widget newWidget, WidgetRef ref) {
    state = newWidget;

    if (newWidget is SwapSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 0;
    } else if (newWidget is PoolListSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 1;
    } else if (newWidget is PoolAddSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 1;
    } else if (newWidget is LiquidityAddSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 1;
    } else if (newWidget is LpStakingSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 2;
    }
  }
}

final _mainScreenWidgetDisplayedProvider =
    StateNotifierProvider<MainScreenWidgetDiplayed, Widget>(
  (ref) => MainScreenWidgetDiplayed(),
);

abstract class MainScreenWidgetDisplayedProviders {
  static final mainScreenWidgetDisplayedProvider =
      _mainScreenWidgetDisplayedProvider;
}
