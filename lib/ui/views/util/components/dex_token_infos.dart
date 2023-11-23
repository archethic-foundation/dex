/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class DexTokenInfos extends StatelessWidget {
  const DexTokenInfos({
    this.token,
    super.key,
  });

  final DexToken? token;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.4),
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (token != null) Text(token!.name),
        ],
      ),
    );
  }
}
