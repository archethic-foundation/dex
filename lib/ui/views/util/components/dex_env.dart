/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DexEnv extends ConsumerStatefulWidget {
  const DexEnv({
    super.key,
  });

  @override
  ConsumerState<DexEnv> createState() => _DexEnvState();
}

class _DexEnvState extends ConsumerState<DexEnv> {
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(SessionProviders.session);

    return SizedBox(
      width: 150,
      child: MenuAnchor(
        style: MenuStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          elevation: MaterialStateProperty.all(0),
        ),
        builder: (context, controller, child) {
          return InkWell(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: Row(
              children: [
                Text(
                  aedappfm.EndpointUtil.getEnvironnementLabel(session.endpoint),
                  style: TextStyle(
                    fontSize: 12,
                    color: aedappfm.EndpointUtil.getEnvironnementLabel(
                              session.endpoint,
                            ) !=
                            'Archethic Mainnet'
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                if (session.isConnected == false)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      controller.isOpen
                          ? aedappfm.Iconsax.arrow_up_2
                          : aedappfm.Iconsax.arrow_down_1,
                      size: 18,
                    ),
                  ),
              ],
            ),
          );
        },
        menuChildren: [
          if (session.isConnected == false)
            MenuItemButton(
              requestFocusOnHover: false,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    aedappfm.EndpointUtil.getEnvironnementLabel(
                      'https://mainnet.archethic.net',
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  if (session.endpoint == 'https://mainnet.archethic.net')
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.check,
                        size: 18,
                      ),
                    ),
                ],
              ),
              onPressed: () async {
                if (session.endpoint == 'https://mainnet.archethic.net') return;
                final poolsListDatasource =
                    await HivePoolsListDatasource.getInstance();
                await poolsListDatasource.clearAll();
                ref
                    .read(SessionProviders.session.notifier)
                    .connectEndpoint('mainnet');
                final preferences =
                    await HivePreferencesDatasource.getInstance();
                aedappfm.sl.get<aedappfm.LogManager>().logsActived =
                    preferences.isLogsActived();
                if (context.mounted) {
                  context.go(SwapSheet.routerPage);
                }
              },
            ),
          if (session.isConnected == false)
            MenuItemButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    aedappfm.EndpointUtil.getEnvironnementLabel(
                      'https://testnet.archethic.net',
                    ),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  if (session.endpoint == 'https://testnet.archethic.net')
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              onPressed: () async {
                if (session.endpoint == 'https://testnet.archethic.net') return;
                final poolsListDatasource =
                    await HivePoolsListDatasource.getInstance();
                await poolsListDatasource.clearAll();
                ref
                    .read(SessionProviders.session.notifier)
                    .connectEndpoint('testnet');
                ref
                  ..invalidate(aedappfm.UcidsTokensProviders.ucidsTokens)
                  ..invalidate(aedappfm.CoinPriceProviders.coinPrice);
                if (context.mounted) {
                  await ref
                      .read(SessionProviders.session.notifier)
                      .updateCtxInfo(context);
                }

                final preferences =
                    await HivePreferencesDatasource.getInstance();
                aedappfm.sl.get<aedappfm.LogManager>().logsActived =
                    preferences.isLogsActived();
                if (context.mounted) {
                  context.go(SwapSheet.routerPage);
                }
              },
            ),
        ],
      ),
    );
  }
}
