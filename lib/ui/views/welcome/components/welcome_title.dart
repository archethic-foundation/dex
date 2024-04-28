import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                aedappfm.GradientText(
                  'SWAP',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
                SelectableText(
                  ' assets on-chain',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                  textScaler: TextScaler.linear(
                    aedappfm.ScaleSize.textScaleFactor(context),
                  ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                'and access yield farming\nby adding liquidity',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(
                  aedappfm.ScaleSize.textScaleFactor(context),
                ),
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .move(
                    begin: const Offset(-16, 0),
                    curve: Curves.easeOutQuad,
                  ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
