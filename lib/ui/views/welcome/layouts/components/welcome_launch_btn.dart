import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeLaunchBtn extends ConsumerStatefulWidget {
  const WelcomeLaunchBtn({
    super.key,
  });
  @override
  WelcomeLaunchBtnState createState() => WelcomeLaunchBtnState();
}

var _over = false;

class WelcomeLaunchBtnState extends ConsumerState<WelcomeLaunchBtn> {
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
                  context.go(SwapSheet.routerPage);
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
                    AppLocalizations.of(context)!.go,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      fontSize: 17,
                    ),
                  ),
                ).animate(target: _over ? 0 : 1).fade(end: 0.8),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              await launchUrl(
                Uri.parse(
                  'https://www.archethic.net/wallet.html',
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                maxLines: 2,
                AppLocalizations.of(context)!.welcomeNoWallet,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
