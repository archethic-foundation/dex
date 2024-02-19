import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
              fontSize: 33,
              color: aedappfm.ArchethicThemeBase.neutral0,
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
            aedappfm.Responsive.isMobile(context) == false &&
            aedappfm.Responsive.isTablet(context) == false)
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
                        context.go(
                          SwapSheet.routerPage,
                          extra: <String, dynamic>{},
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_swap,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 0
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == 0
                          ? aedappfm.ArchethicThemeBase.raspberry200
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
                        context.go(PoolListSheet.routerPage);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_liquidity,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 1
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 90,
                      color: indexMenu == 1
                          ? aedappfm.ArchethicThemeBase.raspberry200
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
                        context.go(FarmListSheet.routerPage);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_farm,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == 2
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == 2
                          ? aedappfm.ArchethicThemeBase.raspberry200
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
