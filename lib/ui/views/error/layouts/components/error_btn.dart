import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorBtn extends ConsumerStatefulWidget {
  const ErrorBtn({
    super.key,
  });
  @override
  ErrorBtnState createState() => ErrorBtnState();
}

var _over = false;

class ErrorBtnState extends ConsumerState<ErrorBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _over = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _over = false;
                });
              },
              child: OutlinedButton(
                style: ButtonStyle(
                  side: WidgetStateProperty.all(BorderSide.none),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  if (!context.mounted) return;
                  launchUrl(
                    Uri.parse('/'),
                    webOnlyWindowName: '_self',
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3D1D63),
                    shape: const StadiumBorder(),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.errorDesc3,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      fontSize: 17,
                    ),
                  ),
                ).animate(target: _over ? 0 : 1).fade(end: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
