import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock/layouts/farm_lock_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/layouts/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends ConsumerWidget {
  const Header({
    this.withMenu = true,
    super.key,
  });

  final bool withMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexMenu = ref.watch(navigationIndexMainScreenProvider);
    final session = ref.watch(SessionProviders.session);
    return Stack(
      children: [
        if (aedappfm.Responsive.isMobile(context) == false)
          Positioned(
            top: 40,
            left: 65,
            child: SelectableText(
              AppLocalizations.of(context)!.headerDecentralizedExchange,
              style: TextStyle(
                fontSize: 10.5,
                color: aedappfm.ArchethicThemeBase.neutral0,
              ),
            ),
          ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            if (aedappfm.Responsive.isMobile(context) == false)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SvgPicture.asset(
                  'assets/images/AELogo.svg',
                  height: 34,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 5),
                child: SvgPicture.asset(
                  'assets/images/AELogo.svg',
                  height: 24,
                ),
              ),
            if (aedappfm.Responsive.isMobile(context) == false)
              const SizedBox(
                width: 8,
              ),
            if (aedappfm.Responsive.isMobile(context) == false)
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
            if (withMenu &&
                aedappfm.Responsive.isMobile(context) == false &&
                aedappfm.Responsive.isTablet(context) == false)
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go(SwapSheet.routerPage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.menu_swap,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: indexMenu == NavigationIndex.swap
                                  ? aedappfm.ArchethicThemeBase.raspberry200
                                  : aedappfm.ArchethicThemeBase.neutral0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 0.5,
                          width: 70,
                          color: indexMenu == NavigationIndex.swap
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go(PoolListSheet.routerPage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.menu_liquidity,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: indexMenu == NavigationIndex.pool
                                  ? aedappfm.ArchethicThemeBase.raspberry200
                                  : aedappfm.ArchethicThemeBase.neutral0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 0.5,
                          width: 90,
                          color: indexMenu == NavigationIndex.pool
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go(FarmLockSheet.routerPage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.menu_earn,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: indexMenu == NavigationIndex.earn
                                  ? aedappfm.ArchethicThemeBase.raspberry200
                                  : aedappfm.ArchethicThemeBase.neutral0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 0.5,
                          width: 70,
                          color: indexMenu == NavigationIndex.earn
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await launchUrl(
                              Uri.parse(
                                (Uri.base
                                        .toString()
                                        .toLowerCase()
                                        .contains('dex.archethic'))
                                    ? 'https://bridge.archethic.net'
                                    : 'https://bridge.testnet.archethic.net',
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.menu_bridge,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: indexMenu == NavigationIndex.bridge
                                  ? aedappfm.ArchethicThemeBase.raspberry200
                                  : aedappfm.ArchethicThemeBase.neutral0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 0.5,
                          width: 70,
                          color: indexMenu == NavigationIndex.bridge
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  if (session.isConnected == false)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                aedappfm.ArchethicThemeBase.blue600
                                    .withOpacity(0.7),
                              ),
                            ),
                            onPressed: () async {
                              await launchUrl(
                                Uri.parse(
                                  'https://www.archethic.net/wallet.html',
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.menu_get_wallet,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: indexMenu == NavigationIndex.getWallet
                                    ? aedappfm.ArchethicThemeBase.raspberry200
                                    : aedappfm.ArchethicThemeBase.neutral0,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 0.5,
                            width: 70,
                            color: indexMenu == NavigationIndex.getWallet
                                ? aedappfm.ArchethicThemeBase.raspberry200
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
