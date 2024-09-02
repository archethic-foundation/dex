import 'dart:ui';

import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class FarmLockBlockListHeader extends ConsumerWidget {
  const FarmLockBlockListHeader({
    required this.onSort,
    required this.sortAscending,
    required this.currentSortedColumn,
    super.key,
  });

  final void Function(String, bool) onSort;
  final Map<String, bool> sortAscending;
  final String currentSortedColumn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = AppTextStyles.bodyMediumSecondaryColor(context);
    return Padding(
      padding: aedappfm.Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
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
                        aedappfm.AppThemeBase.sheetBorderTertiary
                            .withOpacity(0.4),
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
                                _buildHeaderCell(
                                  context,
                                  AppLocalizations.of(context)!
                                      .aeswap_farmLockBlockListHeaderAmount,
                                  style,
                                  'amount',
                                  constraints.maxWidth * 0.15,
                                ),
                                _buildHeaderCell(
                                  context,
                                  AppLocalizations.of(context)!
                                      .aeswap_farmLockBlockListHeaderRewards,
                                  style,
                                  'rewards',
                                  constraints.maxWidth * 0.20,
                                ),
                                _buildHeaderCell(
                                  context,
                                  AppLocalizations.of(context)!
                                      .aeswap_farmLockBlockListHeaderUnlocksIn,
                                  style,
                                  'unlocks_in',
                                  constraints.maxWidth * 0.15,
                                ),
                                _buildHeaderCell(
                                  context,
                                  AppLocalizations.of(context)!
                                      .aeswap_farmLockBlockListHeaderLevel,
                                  style,
                                  'level',
                                  constraints.maxWidth * 0.15,
                                ),
                                _buildHeaderCell(
                                  context,
                                  AppLocalizations.of(context)!
                                      .aeswap_farmLockBlockListHeaderAPR,
                                  style,
                                  'apr',
                                  constraints.maxWidth * 0.10,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.25,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .aeswap_farmLockBlockListHeaderActions,
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
        ],
      ),
    );
  }

  Widget _buildHeaderCell(
    BuildContext context,
    String label,
    TextStyle style,
    String sortBy,
    double width,
  ) {
    return InkWell(
      onTap: () => onSort(sortBy, true),
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: style,
            ),
            const SizedBox(width: 4),
            if (currentSortedColumn == sortBy)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  sortAscending[sortBy]!
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  size: 16,
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.sort,
                  size: 16,
                  color: aedappfm.ArchethicThemeBase.neutral700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
