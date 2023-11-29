import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
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
            ArchethicThemeBase.purple500,
            ArchethicThemeBase.purple500.withOpacity(0.4),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              ArchethicThemeBase.plum300,
              ArchethicThemeBase.plum300.withOpacity(0.4),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            token.symbol,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: VerifiedTokenIcon(
                              address: token.isUCO ? 'UCO' : token.address!,
                              iconSize: 12,
                            ),
                          ),
                        ],
                      ),
                      if (token.balance > 0)
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(
                                Iconsax.empty_wallet,
                                size: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              token.balance.formatNumber(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
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
