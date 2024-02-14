/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/verified_tokens.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifiedTokenIcon extends ConsumerWidget {
  const VerifiedTokenIcon({
    required this.address,
    this.iconSize = 14,
    super.key,
  });

  final String address;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: ref.read(
        VerifiedTokensProviders.isVerifiedToken(address).future,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Tooltip(
                message: 'This token has been verified by Archethic',
                child: Icon(
                  aedappfm.Iconsax.verify,
                  color: aedappfm.ArchethicThemeBase.systemPositive500,
                  size: iconSize,
                ),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
