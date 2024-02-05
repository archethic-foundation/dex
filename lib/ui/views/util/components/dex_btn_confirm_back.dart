/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';

class DexButtonConfirmBack extends StatelessWidget {
  const DexButtonConfirmBack({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SelectableText(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        BackButton(
          onPressed: onPressed,
        ),
      ],
    );
  }
}
