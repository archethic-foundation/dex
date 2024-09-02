import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class ErrorTitle extends StatelessWidget {
  const ErrorTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                aedappfm.GradientText(
                  AppLocalizations.of(context)!.aeswap_errorDesc1,
                  style: const TextStyle(
                    fontSize: 22,
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
                  AppLocalizations.of(context)!.aeswap_errorDesc2,
                  style: const TextStyle(
                    fontSize: 20,
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
          const Spacer(),
        ],
      ),
    );
  }
}
