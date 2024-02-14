/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifiedPoolIcon extends ConsumerWidget {
  const VerifiedPoolIcon({
    required this.isVerified,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final bool isVerified;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isVerified == false) {
      return const SizedBox(
        height: 16,
      );
    }
    return Row(
      children: [
        if (withLabel)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: SelectableText(
              AppLocalizations.of(context)!.poolCardPoolVerified,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3, right: 3),
          child: Tooltip(
            message: 'This pool has been verified by Archethic',
            child: Icon(
              aedappfm.Iconsax.verify,
              color: aedappfm.ArchethicThemeBase.systemPositive500,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
