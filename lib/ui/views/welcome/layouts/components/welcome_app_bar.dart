import 'package:aedex/ui/views/main_screen/layouts/app_bar_menu_links.dart';
import 'package:aedex/ui/views/main_screen/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const WelcomeAppBar({
    super.key,
  });
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<WelcomeAppBar> createState() => _WelcomeAppBarState();
}

class _WelcomeAppBarState extends ConsumerState<WelcomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(withMenu: false),
        leadingWidth: MediaQuery.of(context).size.width,
        actions: const [
          AppBarMenuLinks(),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
