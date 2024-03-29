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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenSheet extends ConsumerStatefulWidget {
  const MainScreenSheet({
    required this.currentStep,
    required this.formSheet,
    required this.confirmSheet,
    this.bottomWidget,
    super.key,
  });

  final aedappfm.ProcessStep currentStep;
  final Widget formSheet;
  final Widget confirmSheet;
  final Widget? bottomWidget;
  @override
  ConsumerState<MainScreenSheet> createState() => MainScreenSheetState();
}

class MainScreenSheetState extends ConsumerState<MainScreenSheet> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        alignment: Alignment.center,
        children: [
          const aedappfm.AppBackground(
            backgroundImage: 'assets/images/background-welcome.png',
          ),
          Align(
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 650,
                    decoration: BoxDecoration(
                      color: aedappfm.AppThemeBase.sheetBackground,
                      border: Border.all(
                        color: aedappfm.AppThemeBase.sheetBorder,
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
                      child: aedappfm.ArchethicScrollbar(
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              if (widget.currentStep ==
                                  aedappfm.ProcessStep.form)
                                widget.formSheet
                              else
                                widget.confirmSheet,
                              if (widget.bottomWidget != null)
                                widget.bottomWidget!,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fade(
                duration: const Duration(milliseconds: 200),
              )
              .scale(
                duration: const Duration(milliseconds: 200),
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
    );
  }
}
