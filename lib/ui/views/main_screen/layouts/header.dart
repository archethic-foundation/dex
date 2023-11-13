/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/layouts/connection_to_wallet_status.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const ConnectionToWalletStatus();
    }

    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        SvgPicture.asset(
          'assets/images/AELogo.svg',
          semanticsLabel: 'AE Logo',
          height: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'DEX',
          style: TextStyle(
            fontSize: 20,
            color: ArchethicThemeBase.blue200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            'Alpha',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
