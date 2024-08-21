/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ArchethicOraclePair extends ConsumerWidget {
  const ArchethicOraclePair({
    required this.token1,
    required this.token2,
    super.key,
  });

  final DexToken token1;
  final DexToken token2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var valueToken1 = 0.0;
    var valueToken2 = 0.0;
    if (token1.isUCO) {
      final archethicOracleUCO =
          ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
      valueToken1 = archethicOracleUCO.usd;
      if (valueToken1 == 0) {
        return const SizedBox.shrink();
      }
    } else {
      valueToken1 = ref.read(DexTokensProviders.estimateTokenInFiat(token1));
      if (valueToken1 == 0) {
        return const SizedBox.shrink();
      }
    }
    if (token2.isUCO) {
      final archethicOracleUCO =
          ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
      valueToken2 = archethicOracleUCO.usd;
      if (valueToken2 == 0) {
        return const SizedBox.shrink();
      }
    } else {
      valueToken2 = ref.read(DexTokensProviders.estimateTokenInFiat(token2));
      if (valueToken2 == 0) {
        return const SizedBox.shrink();
      }
    }

    final timestamp = DateFormat.yMd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.now().toLocal(),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SelectableText(
          '1 ${token1.symbol} = \$${valueToken1.formatNumber(precision: 2)} / 1 ${token2.symbol} = \$${valueToken2.formatNumber(precision: 4)} ($timestamp)',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
          ),
        ),
      ],
    );
  }
}
