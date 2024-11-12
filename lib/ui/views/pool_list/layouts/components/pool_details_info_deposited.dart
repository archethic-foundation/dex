import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool_infos.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoDeposited extends ConsumerWidget {
  const PoolDetailsInfoDeposited({
    super.key,
    required this.pool,
    required this.poolInfos,
  });

  final DexPool pool;
  final DexPoolInfos poolInfos;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final balance = ref
        .watch(
          getBalanceProvider(
            pool.lpToken.address,
          ),
        )
        .value;

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.poolDetailsInfoDeposited,
                style: AppTextStyles.bodyLarge(context),
              ),
              const SizedBox(
                width: 5,
              ),
              FormatAddressLink(
                address: pool.poolAddress,
                typeAddress: TypeAddressLink.chain,
                tooltipLink: AppLocalizations.of(
                  context,
                )!
                    .localHistoryTooltipLinkPool,
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: pool.pair.token1.symbol,
                        child: SelectableText(
                          '${poolInfos.token1Reserve.formatNumber()} ${pool.pair.token1.symbol}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: pool.pair.token2.symbol,
                        child: SelectableText(
                          '${poolInfos.token2Reserve.formatNumber()} ${pool.pair.token2.symbol}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (balance == null)
                        const SizedBox.shrink()
                      else
                        _PoolDetailsInfoDepositedBody(
                          pool: pool,
                          poolInfos: poolInfos,
                          balance: balance,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PoolDetailsInfoDepositedBody extends ConsumerWidget {
  const _PoolDetailsInfoDepositedBody({
    required this.pool,
    required this.balance,
    required this.poolInfos,
  });
  final DexPool pool;
  final double balance;
  final DexPoolInfos poolInfos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amounts = balance <= 0
        ? null
        : ref
            .watch(
              DexTokensProviders.getRemoveAmounts(pool.poolAddress, balance),
            )
            .value;

    var percentage = 0.0;
    if (poolInfos.lpTokenSupply > 0) {
      percentage = (Decimal.parse('100') *
              Decimal.parse(
                '$balance',
              ) /
              Decimal.parse(
                '${poolInfos.lpTokenSupply}',
              ))
          .toDouble();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SelectableText(
              poolInfos.lpTokenSupply == 0 ? '' : balance.formatNumber(),
              style: AppTextStyles.bodyLarge(context),
            ),
            if (poolInfos.lpTokenSupply > 0)
              SelectableText(
                ' / ${poolInfos.lpTokenSupply.formatNumber()} ${poolInfos.lpTokenSupply > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: AppTextStyles.bodyLarge(context),
              )
            else
              SelectableText(
                poolInfos.lpTokenSupply > 1
                    ? AppLocalizations.of(context)!.lpTokens
                    : AppLocalizations.of(context)!.lpToken,
                style: AppTextStyles.bodyLarge(context),
              ),
          ],
        ),
        SelectableText(
          '(${percentage.formatNumber(precision: 8)}%)',
          style: AppTextStyles.bodyMedium(context),
        ),
        if (amounts == null)
          const SizedBox.shrink()
        else
          SelectableText(
            '${AppLocalizations.of(context)!.poolDetailsInfoDepositedEquivalent} ${amounts.token1.formatNumber(precision: amounts.token1 > 1 ? 2 : 8)} ${pool.pair.token1.symbol.reduceSymbol()} / ${amounts.token2.formatNumber(precision: amounts.token2 > 1 ? 2 : 8)} ${pool.pair.token2.symbol.reduceSymbol()}',
            style: AppTextStyles.bodyMedium(context),
          ),
      ],
    );
  }
}
