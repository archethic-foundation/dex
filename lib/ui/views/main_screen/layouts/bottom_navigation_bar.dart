import 'dart:ui';

import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_lock/farm_lock_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/icon_size.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: widget.listNavigationLabelIcon.map((item) {
            var selected = false;
            final tabSelected = ref
                .read(
                  navigationIndexMainScreenProvider.notifier,
                )
                .state;
            var widthContainer = 0.0;
            switch (item.$2) {
              case aedappfm.Iconsax.arrange_circle_2:
                if (tabSelected == NavigationIndex.swap) {
                  widthContainer = 30;
                  selected = true;
                }
                break;
              case aedappfm.Iconsax.wallet_money:
                if (tabSelected == NavigationIndex.pool) {
                  widthContainer = 45;
                  selected = true;
                }
                break;
              case aedappfm.Iconsax.coin5:
                if (tabSelected == NavigationIndex.farm) {
                  widthContainer = 30;
                  selected = true;
                }
                break;
              case aedappfm.Iconsax.coin5:
                if (tabSelected == NavigationIndex.earn) {
                  widthContainer = 30;
                  selected = true;
                }
                break;
              default:
            }

            return BottomNavigationBarItem(
              label: '',
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$2,
                        weight: IconSize.weightM,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                      ),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (selected)
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: widthContainer,
                        height: 2,
                        color: aedappfm.ArchethicThemeBase.neutral0,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          currentIndex: widget.navDrawerIndex.index,
          onTap: (int selectedIndex) async {
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
              case 3:
                setState(() {
                  ref
                      .read(
                        navigationIndexMainScreenProvider.notifier,
                      )
                      .state = NavigationIndex.earn;
                });
                context.go(FarmLockSheet.routerPage);
                break;
              case 4:
                setState(() {
                  ref
                      .read(
                        navigationIndexMainScreenProvider.notifier,
                      )
                      .state = NavigationIndex.bridge;
                });
                await launchUrl(
                  Uri.parse(
                    (Uri.base
                            .toString()
                            .toLowerCase()
                            .contains('dex.archethic'))
                        ? 'https://bridge.archethic.net'
                        : 'https://bridge.testnet.archethic.net',
                  ),
                );
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
