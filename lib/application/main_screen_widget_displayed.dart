/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidgetDiplayed extends StateNotifier<Widget> {
  MainScreenWidgetDiplayed() : super(const SwapSheet());

  void setWidget(Widget newWidget) {
    state = SizedBox(child: newWidget);
  }
}

final _mainScreenWidgetDiplayedProvider =
    StateNotifierProvider<MainScreenWidgetDiplayed, Widget>(
  (ref) => MainScreenWidgetDiplayed(),
);

abstract class MainScreenWidgetDiplayedProviders {
  static final mainScreenWidgetDiplayedProvider =
      _mainScreenWidgetDiplayedProvider;
}
