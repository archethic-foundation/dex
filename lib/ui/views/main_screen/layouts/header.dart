/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:aedex/ui/views/yield_farming/yield_farming_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  const Header({
    this.withMenu = true,
    super.key,
  });

  final bool withMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexMenu = ref.watch(navigationIndexMainScreenProvider);

    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Image.asset(
          'assets/images/logo_crystal.png',
          height: 50,
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'aeSwap',
            style: TextStyle(
              fontSize: 30,
              color: ArchethicThemeBase.blue200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 20),
          child: Text(
            'Alpha',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        if (withMenu &&
            Responsive.isMobile(context) == false &&
            Responsive.isTablet(context) == false)
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        0;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const SwapSheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_swap,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 0
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        1;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const PoolListSheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_liquidity,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 1
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        2;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const YieldFarmingSheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_yield_farming,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 2
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
