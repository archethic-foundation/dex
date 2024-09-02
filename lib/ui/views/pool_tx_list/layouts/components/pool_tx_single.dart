import 'package:aedex/domain/enum/dex_action_type.dart';
import 'package:aedex/domain/models/dex_pool_tx.dart';

import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:timeago/timeago.dart' as timeago;

class PoolListSingle extends ConsumerWidget {
  const PoolListSingle({super.key, required this.dexPoolTx});

  final DexPoolTx dexPoolTx;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final style = TextStyle(
      fontSize: aedappfm.Responsive.fontSizeFromValue(
        context,
        desktopValue: 13,
        ratioMobile: 3,
        ratioTablet: 1,
      ),
    );
    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: dexPoolTx.typeTx == DexActionType.swap
            ? LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBackgroundTertiary
                      .withOpacity(0.4),
                  aedappfm.AppThemeBase.sheetBackgroundTertiary,
                ],
                stops: const [0, 1],
              )
            : LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBackgroundSecondary
                      .withOpacity(0.4),
                  aedappfm.AppThemeBase.sheetBackgroundSecondary,
                ],
                stops: const [0, 1],
              ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              aedappfm.AppThemeBase.sheetBorderTertiary.withOpacity(0.4),
              aedappfm.AppThemeBase.sheetBorderTertiary,
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 6, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  dexPoolTx.typeTx == null
                      ? AppLocalizations.of(context)!.aeswap_poolTxTypeUnknown
                      : '${dexPoolTx.typeTx!.getLabel(context)}  ',
                  style: style,
                ),
                SelectableText(
                  timeago.format(dexPoolTx.time!),
                  style: style,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (dexPoolTx.token1Amount != null &&
                    dexPoolTx.token1 != null &&
                    dexPoolTx.token2Amount != null &&
                    dexPoolTx.token2 != null)
                  SelectableText(
                    '${dexPoolTx.token1Amount!.formatNumber(precision: aedappfm.Responsive.isMobile(context) == true ? 2 : 8)} ${dexPoolTx.token1!.symbol.trim()} ${dexPoolTx.typeTx == DexActionType.swap ? ' for ' : ' and '} ${dexPoolTx.token2Amount!.formatNumber(precision: aedappfm.Responsive.isMobile(context) == true ? 2 : 8)} ${dexPoolTx.token2!.symbol.trim()}',
                    style: style,
                  )
                else
                  const SelectableText(''),
                if (aedappfm.Responsive.isMobile(context) == false)
                  SelectableText(
                    AppLocalizations.of(context)!.aeswap_poolTxAccount,
                    style: style,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (dexPoolTx.totalValue == null)
                      SelectableText(
                        '',
                        style: style,
                      )
                    else
                      SelectableText(
                        '${AppLocalizations.of(context)!.aeswap_poolTxTotalValue} ${dexPoolTx.totalValue! < 0.01 ? '<' : ''} ${dexPoolTx.totalValue == null ? r'$0' : '\$${dexPoolTx.totalValue!.formatNumber(precision: 2)}'}',
                        style: style,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                if (aedappfm.Responsive.isMobile(context) == false)
                  if (dexPoolTx.addressAccount != null)
                    FormatAddressLinkCopy(
                      address: dexPoolTx.addressAccount!.toUpperCase(),
                      typeAddress: TypeAddressLinkCopy.chain,
                      reduceAddress: true,
                      ratioMobile: 1,
                      ratioTablet: 1,
                    ),
              ],
            ),
            if (aedappfm.Responsive.isMobile(context) == true)
              if (dexPoolTx.addressAccount != null)
                FormatAddressLinkCopy(
                  address: dexPoolTx.addressAccount!.toUpperCase(),
                  typeAddress: TypeAddressLinkCopy.chain,
                  reduceAddress: true,
                  ratioMobile: 3,
                  ratioTablet: 1,
                ),
          ],
        ),
      ),
    );
  }
}
