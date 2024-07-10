import 'dart:ui';

import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class FarmLockDetailsInfoLPDepositedLeveHeader extends ConsumerWidget {
  const FarmLockDetailsInfoLPDepositedLeveHeader({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: aedappfm.Responsive.isDesktop(context) ? 50 : 30,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.4),
                aedappfm.AppThemeBase.sheetBackgroundTertiary,
              ],
              stops: const [0, 1],
            ),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBorderTertiary.withOpacity(0.4),
                  aedappfm.AppThemeBase.sheetBorderTertiary,
                ],
                stops: const [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.15,
                      child: Align(
                        child: SelectableText(
                          AppLocalizations.of(context)!.level,
                          style:
                              AppTextStyles.bodyMediumSecondaryColor(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.15,
                      child: Align(
                        child: SelectableText(
                          AppLocalizations.of(context)!
                              .farmDetailsInfoNbDeposit,
                          style:
                              AppTextStyles.bodyMediumSecondaryColor(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.70,
                      child: Align(
                        child: SelectableText(
                          AppLocalizations.of(context)!
                              .farmDetailsInfoLPDeposited,
                          style:
                              AppTextStyles.bodyMediumSecondaryColor(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
