/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aedex/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenList extends ConsumerStatefulWidget {
  const MainScreenList({
    required this.body,
    this.bodyVerticalAlignment = Alignment.center,
    this.withBackground = true,
    super.key,
  });

  final Widget body;
  final Alignment bodyVerticalAlignment;
  final bool withBackground;
  @override
  ConsumerState<MainScreenList> createState() => MainScreenListState();
}

class MainScreenListState extends ConsumerState<MainScreenList> {
  List<(String, IconData)> listNavigationLabelIcon = [];

  @override
  void initState() {
    super.initState();

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      Future(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const BrowserPopup();
          },
        );
      });
    }
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
      (AppLocalizations.of(context)!.menu_earn, aedappfm.Iconsax.wallet_add),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'aeSwap - Archethic DEX to swap, stake and farm UCO token',
      color: Colors.black,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const AppBarMainScreen(),
            ),
          ),
        ),
        body: Stack(
          alignment: widget.bodyVerticalAlignment,
          children: [
            if (widget.withBackground)
              const aedappfm.AppBackground(
                backgroundImage: 'assets/images/background-welcome.png',
              ),
            widget.body,
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
