import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoNbDeposit extends ConsumerWidget {
  const FarmDetailsInfoNbDeposit({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.aeswap_farmDetailsInfoNbDeposit,
          style: AppTextStyles.bodyLarge(context),
        ),
        SelectableText(
          farm.nbDeposit.toString(),
          style: AppTextStyles.bodyLarge(context),
        ),
      ],
    );
  }
}
