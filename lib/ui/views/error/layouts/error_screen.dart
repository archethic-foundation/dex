import 'dart:ui';

import 'package:aedex/ui/views/error/layouts/components/error_app_bar.dart';
import 'package:aedex/ui/views/error/layouts/components/error_btn.dart';
import 'package:aedex/ui/views/error/layouts/components/error_title.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({
    super.key,
  });

  static const routerPage = '/error';
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
            child: const ErrorAppBar(),
          ),
        ),
      ),
      body: const Stack(
        alignment: Alignment.center,
        children: [
          aedappfm.AppBackground(
            withAnimation: true,
            backgroundImage: 'assets/images/background-welcome.png',
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorTitle(),
              ErrorBtn(),
            ],
          ),
        ],
      ),
    );
  }
}
