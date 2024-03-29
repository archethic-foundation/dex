import 'dart:ui';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarMainScreen extends ConsumerStatefulWidget {
  const BottomNavigationBarMainScreen({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
  });

  final NavigationIndex navDrawerIndex;
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
          currentIndex: widget.navDrawerIndex.index,
          onTap: (int selectedIndex) {
            switch (selectedIndex) {
              case 0:
                setState(() {
                  ref
                      .read(
                        navigationIndexMainScreenProvider.notifier,
                      )
                      .state = NavigationIndex.swap;
                });
                context.go(SwapSheet.routerPage);
                break;
              case 1:
                setState(() {
                  ref
                      .read(
                        navigationIndexMainScreenProvider.notifier,
                      )
                      .state = NavigationIndex.pool;
                });
                context.go(PoolListSheet.routerPage);
                break;
              case 2:
                setState(() {
                  ref
                      .read(
                        navigationIndexMainScreenProvider.notifier,
                      )
                      .state = NavigationIndex.farm;
                });
                context.go(FarmListSheet.routerPage);
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
