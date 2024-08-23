import 'package:aedex/ui/views/main_screen/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const ErrorAppBar({
    super.key,
  });
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<ErrorAppBar> createState() => _ErrorAppBarState();
}

class _ErrorAppBarState extends ConsumerState<ErrorAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(withMenu: false),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}
