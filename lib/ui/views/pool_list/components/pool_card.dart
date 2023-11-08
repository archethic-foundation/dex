/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class PoolCard extends StatelessWidget {
  const PoolCard({
    required this.pool,
    super.key,
  });

  final DexPool pool;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: DexThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: DexThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background-sheet.png',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 40,
              spreadRadius: 10,
              offset: const Offset(1, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Pool Address: '),
                        FormatAddressLinkCopy(
                          address: pool.poolAddress,
                          reduceAddress: true,
                        ),
                      ],
                    ),
                    if (pool.pair != null)
                      Text(
                        'Pair: ${pool.pair!.token1.symbol}-${pool.pair!.token2.symbol}',
                      ),
                    if (pool.pair != null)
                      Row(
                        children: [
                          const Text('Pair addresses: '),
                          FormatAddressLinkCopy(
                            address: pool.pair!.token1.address!,
                            reduceAddress: true,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('/'),
                          const SizedBox(
                            width: 5,
                          ),
                          FormatAddressLinkCopy(
                            address: pool.pair!.token2.address!,
                            reduceAddress: true,
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        const Text('LP Token: '),
                        FormatAddressLinkCopy(
                          address: pool.lpTokenAddress,
                          reduceAddress: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
