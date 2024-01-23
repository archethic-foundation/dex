/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/body.dart';
import 'package:aedex/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aedex/ui/views/main_screen/layouts/privacy_popup.dart';
import 'package:aedex/ui/views/util/components/dex_background.dart';
import 'package:aedex/ui/views/util/components/dex_env.dart';
import 'package:aedex/ui/views/util/components/dex_main_menu_app.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:busy/busy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  bool _isSubMenuOpen = false;
  List<(String, IconData)> listNavigationLabelIcon = [];

  @override
  void initState() {
    super.initState();

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const BrowserPopup();
          },
        );
      });
    }

    HivePreferencesDatasource.getInstance().then((value) {
      if (value.isFirstConnection()) {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PrivacyPopup();
            },
          );
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listNavigationLabelIcon = [
      (AppLocalizations.of(context)!.menu_swap, Iconsax.arrange_circle_2),
      (AppLocalizations.of(context)!.menu_liquidity, Iconsax.wallet_money),
      (AppLocalizations.of(context)!.menu_farm, Iconsax.coin5),
    ];
  }

  void _toggleSubMenu() {
    setState(() {
      _isSubMenuOpen = !_isSubMenuOpen;
    });
    return;
  }

  void _closeSubMenu() {
    setState(() {
      _isSubMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSubMenu,
      child: BusyScaffold(
        isBusy: ref.watch(isLoadingMainScreenProvider),
        scaffold: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: DexThemeBase.backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AppBarMainScreen(
                  onAEMenuTapped: _toggleSubMenu,
                ),
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topRight,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const DexBackground(),
                  Body(
                    listNavigationLabelIcon: listNavigationLabelIcon,
                    navDrawerIndex:
                        ref.watch(navigationIndexMainScreenProvider),
                  ),
                  if (_isSubMenuOpen) const DexMainMenuApp(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 80, right: 20),
                child: DexEnv(),
              ),
            ],
          ),
          bottomNavigationBar: Responsive.isMobile(context) ||
                  Responsive.isTablet(context)
              ? BottomNavigationBarMainScreen(
                  listNavigationLabelIcon: listNavigationLabelIcon,
                  navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
                )
              : null,
        ),
      ),
    );
  }
}
