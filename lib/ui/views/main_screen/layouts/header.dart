/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
        SvgPicture.asset(
          'assets/images/AELogo.svg',
          height: 34,
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: SelectableText(
            'aeSwap',
            style: TextStyle(
              fontSize: 34,
              color: ArchethicThemeBase.neutral0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 26),
          child: SelectableText(
            'Beta',
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
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(navigationIndexMainScreenProvider.notifier)
                            .state = 0;
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
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 0
                              ? ArchethicThemeBase.raspberry200
                              : ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == 0
                          ? ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(navigationIndexMainScreenProvider.notifier)
                            .state = 1;
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
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 1
                              ? ArchethicThemeBase.raspberry200
                              : ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 90,
                      color: indexMenu == 1
                          ? ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(navigationIndexMainScreenProvider.notifier)
                            .state = 2;
                        ref
                            .read(
                              MainScreenWidgetDisplayedProviders
                                  .mainScreenWidgetDisplayedProvider.notifier,
                            )
                            .setWidget(const FarmListSheet(), ref);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_farm,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 2
                              ? ArchethicThemeBase.raspberry200
                              : ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == 2
                          ? ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
