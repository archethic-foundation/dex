/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aedex/ui/views/main_screen/layouts/privacy_popup.dart';
import 'package:aedex/ui/views/util/components/dex_background.dart';
import 'package:aedex/ui/views/util/components/dex_env.dart';
import 'package:aedex/ui/views/util/components/dex_main_menu_app.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenList extends ConsumerStatefulWidget {
  const MainScreenList({required this.body, super.key});

  final Widget body;
  @override
  ConsumerState<MainScreenList> createState() => MainScreenListState();
}

class MainScreenListState extends ConsumerState<MainScreenList> {
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
      (
        AppLocalizations.of(context)!.menu_swap,
        aedappfm.Iconsax.arrange_circle_2
      ),
      (
        AppLocalizations.of(context)!.menu_liquidity,
        aedappfm.Iconsax.wallet_money
      ),
      (AppLocalizations.of(context)!.menu_farm, aedappfm.Iconsax.coin5),
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
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
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
                widget.body
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 200),
                    )
                    .scale(
                      duration: const Duration(milliseconds: 200),
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
        bottomNavigationBar: aedappfm.Responsive.isMobile(context) ||
                aedappfm.Responsive.isTablet(context)
            ? BottomNavigationBarMainScreen(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
              )
            : null,
      ),
    );
  }
}