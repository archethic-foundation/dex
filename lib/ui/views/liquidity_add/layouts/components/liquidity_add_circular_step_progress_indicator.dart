/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LiquidityAddCircularStepProgressIndicator extends ConsumerWidget {
  const LiquidityAddCircularStepProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Align(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularStepProgressIndicator(
              totalSteps: 1,
              currentStep: 1,
              width: 35,
              height: 35,
              stepSize: 2,
              roundedCap: (_, isSelected) => isSelected,
              gradientColor: liquidityAdd.isProcessInProgress == false
                  ? liquidityAdd.failure == null
                      ? DexThemeBase
                          .gradientCircularStepProgressIndicatorFinished
                      : DexThemeBase.gradientCircularStepProgressIndicatorError
                  : DexThemeBase.gradientCircularStepProgressIndicator,
              selectedColor: Colors.white,
              unselectedColor: Colors.white.withOpacity(0.2),
              removeRoundedCapExtraAngle: true,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                if (liquidityAdd.isProcessInProgress)
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                const Icon(
                  Iconsax.timer,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}