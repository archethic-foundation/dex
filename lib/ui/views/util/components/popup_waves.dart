/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class PopupWaves extends StatelessWidget {
  const PopupWaves({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            ArchethicThemeBase.blue700.withOpacity(0.1),
            ArchethicThemeBase.purple800.withOpacity(0.1),
          ],
          [
            ArchethicThemeBase.blue600.withOpacity(0.1),
            ArchethicThemeBase.purple500.withOpacity(0.1),
          ],
          [
            ArchethicThemeBase.blue400.withOpacity(0.1),
            ArchethicThemeBase.purple500.withOpacity(0.1),
          ],
        ],
        durations: [
          35000,
          19440,
          10800,
        ],
        heightPercentages: [
          0.20,
          0.23,
          0.25,
        ],
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      size: Size.infinite,
      waveAmplitude: 0,
    );
  }
}
