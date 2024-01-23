/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/ui/views/util/components/icon_button_animated.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DexArchethicOracleUco extends ConsumerWidget {
  const DexArchethicOracleUco({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archethicOracleUCO =
        ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);
    if (archethicOracleUCO.usd == 0) {
      return const SizedBox.shrink();
    }
    final timestamp = DateFormat.yMd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.fromMillisecondsSinceEpoch(
            archethicOracleUCO.timestamp * 1000,
          ).toLocal(),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButtonAnimated(
          icon: const Icon(
            Icons.help,
            size: 16,
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/category/faq/dex#how-is-the-price-of-uco-estimated',
              ),
            );
          },
          color: Colors.white,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '1 UCO = \$${archethicOracleUCO.usd.formatNumber(precision: 2)} ($timestamp)',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
