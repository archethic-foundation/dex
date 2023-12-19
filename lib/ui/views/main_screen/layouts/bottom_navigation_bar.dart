import 'dart:ui';

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/yield_farming/yield_farming_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarMainScreen extends ConsumerStatefulWidget {
  const BottomNavigationBarMainScreen({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
  });

  final int navDrawerIndex;
  final List<(String, IconData)> listNavigationLabelIcon;

  @override
  ConsumerState<BottomNavigationBarMainScreen> createState() =>
      _BottomNavigationBarMainScreenState();
}

class _BottomNavigationBarMainScreenState
    extends ConsumerState<BottomNavigationBarMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: widget.listNavigationLabelIcon
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.$1,
                  icon: Icon(item.$2),
                ),
              )
              .toList(),
          currentIndex: widget.navDrawerIndex,
          onTap: (int selectedIndex) {
            setState(() {
              ref.read(navigationIndexMainScreenProvider.notifier).state =
                  selectedIndex;
            });

            switch (selectedIndex) {
              case 0:
                ref
                    .read(
                      MainScreenWidgetDisplayedProviders
                          .mainScreenWidgetDisplayedProvider.notifier,
                    )
                    .setWidget(const SwapSheet(), ref);

                break;
              case 1:
                ref
                    .read(
                      MainScreenWidgetDisplayedProviders
                          .mainScreenWidgetDisplayedProvider.notifier,
                    )
                    .setWidget(const PoolListSheet(), ref);

                break;

              case 2:
                ref
                    .read(
                      MainScreenWidgetDisplayedProviders
                          .mainScreenWidgetDisplayedProvider.notifier,
                    )
                    .setWidget(const YieldFarmingSheet(), ref);

                break;

              default:
                break;
            }
          },
        ),
      ),
    );
  }
}
