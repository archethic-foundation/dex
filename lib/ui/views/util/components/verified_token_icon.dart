/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifiedTokenIcon extends ConsumerWidget {
  const VerifiedTokenIcon({
    required this.address,
    super.key,
  });

  final String address;

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
              child: Icon(
                Iconsax.verify,
                color: ArchethicThemeBase.systemPositive500,
                size: 14,
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
