import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/gradient_text.dart';
import 'package:aedex/ui/views/util/components/scale_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  'SWAP',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                  gradient: DexThemeBase.gradientWelcomeTxt,
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
                Text(
                  ' assets on-chain,',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'add liquidity & access LP staking',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
