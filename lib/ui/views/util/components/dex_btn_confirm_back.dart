/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexButtonConfirmBack extends StatelessWidget {
  const DexButtonConfirmBack({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            '< ${AppLocalizations.of(context)!.btn_back}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
