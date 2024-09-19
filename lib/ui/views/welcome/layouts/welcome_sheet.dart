import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeSheet extends ConsumerStatefulWidget {
  const WelcomeSheet({super.key});

  static const routerPage = '/welcome';

  @override
  ConsumerState<WelcomeSheet> createState() => _WelcomeSheetState();
}

class _WelcomeSheetState extends ConsumerState<WelcomeSheet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.welcome;
    });

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (mounted == false) {
      return const SizedBox.shrink();
    }
    return const MainScreenList(
      withBackground: false,
      body: Padding(
        padding: EdgeInsets.only(top: 70),
        child: EasyWebView(
          src: 'https://swap.archethic.net/dex.html',
        ),
      ),
    );
  }
}
