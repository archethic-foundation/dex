/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
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
      alignment: Alignment.center,
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ArchethicThemeBase.purple500,
            ArchethicThemeBase.purple500.withOpacity(0.4),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              ArchethicThemeBase.paleTransparentBackground,
              ArchethicThemeBase.paleTransparentBackground.withOpacity(0.4),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: token != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: [
                  DexTokenIcon(
                    tokenAddress:
                        token!.address == null ? 'UCO' : token!.address!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Text(token!.symbol),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
