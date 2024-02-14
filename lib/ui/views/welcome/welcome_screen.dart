import 'dart:ui';

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/layouts/app_bar_welcome.dart';
import 'package:aedex/ui/views/util/components/dex_background.dart';
import 'package:aedex/ui/views/util/components/dex_main_menu_app.dart';
import 'package:aedex/ui/views/welcome/components/welcome_launch_btn.dart';
import 'package:aedex/ui/views/welcome/components/welcome_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  static const routerPage = '/welcome';

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _isSubMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSubMenu,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: DexThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBarWelcome(
                onAEMenuTapped: _toggleSubMenu,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            const DexBackground(withAnimation: true),
            const Column(
              children: [
                WelcomeTitle(),
                WelcomeLaunchBtn(),
              ],
            ),
            if (_isSubMenuOpen)
              const DexMainMenuApp(
                withFaucet: false,
              ),
          ],
        ),
      ),
    );
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
}
