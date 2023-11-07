import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInfo extends ConsumerWidget {
  const PoolAddInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      AppLocalizations.of(context)!.poolAddInfo,
    );
  }
}
