/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/verified_pools.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifiedPoolIcon extends ConsumerWidget {
  const VerifiedPoolIcon({
    required this.address,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final String address;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: ref.read(
        VerifiedPoolsProviders.isVerifiedPool(address).future,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return Row(
              children: [
                if (withLabel)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      AppLocalizations.of(context)!.poolCardPoolVerified,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Icon(
                    Iconsax.verify,
                    color: ArchethicThemeBase.systemPositive500,
                    size: iconSize,
                  ),
                ),
              ],
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}