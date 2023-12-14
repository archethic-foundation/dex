/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      width: 200,
      child: MenuAnchor(
        style: MenuStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
        ),
        alignmentOffset: Offset(MediaQuery.of(context).size.width, 10),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/AELogo.svg',
                  semanticsLabel: 'AE Logo',
                  height: 14,
                  colorFilter: ColorFilter.mode(
                    EndpointUtil.getEnvironnementLabel(session.endpoint) !=
                            'Archethic Mainnet'
                        ? Colors.red
                        : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  EndpointUtil.getEnvironnementLabel(session.endpoint),
                ),
                const SizedBox(width: 5),
                if (session.isConnected == false)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      controller.isOpen
                          ? Iconsax.arrow_up_2
                          : Iconsax.arrow_down_1,
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
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/AELogo.svg',
                      semanticsLabel: 'AE Logo',
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Colors.red,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      EndpointUtil.getEnvironnementLabel(
                        'https://testnet.archethic.net',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    if (session.endpoint == 'https://testnet.archethic.net')
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.check,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ),
              onPressed: () {
                if (session.endpoint == 'https://testnet.archethic.net') return;
                ref
                    .read(SessionProviders.session.notifier)
                    .connectEndpoint('testnet');
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
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/AELogo.svg',
                      semanticsLabel: 'AE Logo',
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      EndpointUtil.getEnvironnementLabel(
                        'https://mainnet.archethic.net',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
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
              ),
              onPressed: () {
                if (session.endpoint == 'https://mainnet.archethic.net') return;
                ref
                    .read(SessionProviders.session.notifier)
                    .connectEndpoint('mainnet');
              },
            ),
        ],
      ),
    );
  }
}
