import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SingleToken extends StatelessWidget {
  const SingleToken({super.key, required this.token});

  final DexToken token;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DexThemeBase.sheetBackgroundTertiary.withOpacity(0.4),
            DexThemeBase.sheetBackgroundTertiary,
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              DexThemeBase.sheetBorderTertiary.withOpacity(0.4),
              DexThemeBase.sheetBorderTertiary,
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, token);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                DexTokenIcon(
                  tokenAddress: token.address == null ? 'UCO' : token.address!,
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    children: [
                      if (token.isLpToken == false)
                        Text(
                          token.symbol,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      if (token.isLpToken == false)
                        const SizedBox(
                          width: 3,
                        ),
                      if (token.isLpToken == false)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: VerifiedTokenIcon(
                            address: token.isUCO ? 'UCO' : token.address!,
                            iconSize: 12,
                          ),
                        ),
                      if (token.isLpToken && token.lpTokenPair != null)
                        Text(
                          'LP Token for pair ${token.lpTokenPair!.token1.isUCO ? 'UCO' : token.lpTokenPair!.token1.symbol}/${token.lpTokenPair!.token2.isUCO ? 'UCO' : token.lpTokenPair!.token2.symbol}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (token.address != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FormatAddressLinkCopy(
                  address: token.address!,
                  fontSize: 11,
                  reduceAddress: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
