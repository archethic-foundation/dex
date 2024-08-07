import 'dart:ui';

import 'package:aedex/ui/views/welcome/layouts/components/welcome_app_bar.dart';
import 'package:aedex/ui/views/welcome/layouts/components/welcome_launch_btn.dart';
import 'package:aedex/ui/views/welcome/layouts/components/welcome_title.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({
    super.key,
  });

  static const routerPage = '/welcome';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: aedappfm.AppThemeBase.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const WelcomeAppBar(),
          ),
        ),
      ),
      body: const Stack(
        children: [
          aedappfm.AppBackground(
            withAnimation: true,
            backgroundImage: 'assets/images/background-welcome.png',
          ),
          Column(
            children: [
              WelcomeTitle(),
              WelcomeLaunchBtn(),
            ],
          ),
        ],
      ),
    );
  }
}
