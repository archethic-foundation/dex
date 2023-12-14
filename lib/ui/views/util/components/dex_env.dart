/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DexEnv extends ConsumerWidget {
  const DexEnv({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    var colorIcon = Colors.white;
    if (EndpointUtil.getEnvironnementLabel(session.endpoint) !=
        'Archethic Mainnet') {
      colorIcon = Colors.red;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          'assets/images/AELogo.svg',
          semanticsLabel: 'AE Logo',
          height: 14,
          colorFilter: ColorFilter.mode(colorIcon, BlendMode.srcIn),
        ),
        const SizedBox(width: 10),
        Text(
          EndpointUtil.getEnvironnementLabel(session.endpoint),
        ),
        const SizedBox(width: 5),
        const Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Icon(
            Iconsax.arrow_down_1,
            size: 18,
          ),
        ),
      ],
    );
  }
}
