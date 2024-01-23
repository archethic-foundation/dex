/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexButtonClose extends ConsumerWidget {
  const DexButtonClose({
    required this.onPressed,
    super.key,
    this.background = const Color(0xFF3D1D63),
  });

  final VoidCallback onPressed;
  final Color background;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      background: background,
      labelBtn: AppLocalizations.of(context)!.btn_close,
      onPressed: onPressed,
    );
  }
}
