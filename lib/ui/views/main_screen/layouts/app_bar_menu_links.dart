import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMenuLinks extends ConsumerWidget {
  const AppBarMenuLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.only(top: 20, right: 20),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      alignmentOffset: const Offset(0, 2),
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(aedappfm.Iconsax.element_3),
        );
      },
      menuChildren: [
        MenuItemButton(
          requestFocusOnHover: false,
          child: SizedBox(
            height: 100,
            child: aedappfm.SingleCard(
              globalPadding: 0,
              cardContent: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuBridgeItem,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        AppLocalizations.of(context)!
                            .archethicDashboardMenuBridgeDesc,
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                (Uri.base.toString().toLowerCase().contains('dex.archethic'))
                    ? 'https://bridge.archethic.net'
                    : 'https://bridge.testnet.archethic.net',
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        MenuItemButton(
          requestFocusOnHover: false,
          child: SizedBox(
            height: 100,
            child: aedappfm.SingleCard(
              globalPadding: 0,
              cardContent: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuWalletOnWayItem,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        AppLocalizations.of(context)!
                            .archethicDashboardMenuWalletOnWayDesc,
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                'https://www.archethic.net/wallet.html',
              ),
            );
          },
        ),
        if (Uri.base.toString().toLowerCase().contains('dex.testnet.archethic'))
          const SizedBox(
            height: 20,
          ),
        if (Uri.base.toString().toLowerCase().contains('dex.testnet.archethic'))
          MenuItemButton(
            requestFocusOnHover: false,
            child: SizedBox(
              height: 100,
              child: aedappfm.SingleCard(
                globalPadding: 0,
                cardContent: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .archethicDashboardMenuFaucetItem,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          AppLocalizations.of(context)!
                              .archethicDashboardMenuFaucetDesc,
                          textAlign: TextAlign.end,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onPressed: () async {
              await launchUrl(
                Uri.parse(
                  'https://testnet.archethic.net/faucet',
                ),
              );
            },
          ),
      ],
    );
  }
}
