import 'dart:ui';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class FarmLockBlockListHeader extends ConsumerWidget {
  const FarmLockBlockListHeader({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
        );
    return Padding(
      padding: aedappfm.Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: aedappfm.Responsive.isDesktop(context) ? 50 : 30,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBackgroundTertiary
                      .withOpacity(0.4),
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
                  return aedappfm.Responsive.isDesktop(context)
                      ? Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.15,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .farmLockBlockListHeaderAmount,
                                  style: style,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.20,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .farmLockBlockListHeaderRewards,
                                  style: style,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.15,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .farmLockBlockListHeaderUnlocksIn,
                                  style: style,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .farmLockBlockListHeaderLevel,
                                    style: style,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Icon(
                                      Icons.info_outline,
                                      color:
                                          aedappfm.AppThemeBase.secondaryColor,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.10,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .farmLockBlockListHeaderAPR,
                                  style: style,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.25,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .farmLockBlockListHeaderActions,
                                  style: style,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
