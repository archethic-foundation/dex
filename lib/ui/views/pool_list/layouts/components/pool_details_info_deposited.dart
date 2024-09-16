import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoDeposited extends ConsumerWidget {
  const PoolDetailsInfoDeposited({
    super.key,
    required this.pool,
  });

  final DexPool? pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    final apiService = aedappfm.sl.get<ApiService>();

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
                address: pool!.poolAddress,
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
                        message: pool!.pair.token1.symbol,
                        child: SelectableText(
                          '${pool!.pair.token1.reserve.formatNumber()} ${pool!.pair.token1.symbol}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: pool!.pair.token2.symbol,
                        child: SelectableText(
                          '${pool!.pair.token2.reserve.formatNumber()} ${pool!.pair.token2.symbol}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FutureBuilder<double>(
                        future: ref.watch(
                          getBalanceProvider(
                            session.genesisAddress,
                            pool!.lpToken.address!,
                            apiService,
                          ).future,
                        ),
                        builder: (context, snapshotBalance) {
                          if (snapshotBalance.hasData) {
                            var percentage = 0.0;
                            if (pool!.lpToken.supply > 0) {
                              percentage = (Decimal.parse('100') *
                                      Decimal.parse(
                                        '${snapshotBalance.data!}',
                                      ) /
                                      Decimal.parse(
                                        '${pool!.lpToken.supply}',
                                      ))
                                  .toDouble();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SelectableText(
                                      pool!.lpToken.supply == 0
                                          ? ''
                                          : snapshotBalance.data!
                                              .formatNumber(),
                                      style: AppTextStyles.bodyLarge(context),
                                    ),
                                    if (pool!.lpToken.supply > 0)
                                      SelectableText(
                                        ' / ${pool!.lpToken.supply.formatNumber()} ${pool!.lpToken.supply > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                                        style: AppTextStyles.bodyLarge(context),
                                      )
                                    else
                                      SelectableText(
                                        pool!.lpToken.supply > 1
                                            ? AppLocalizations.of(context)!
                                                .lpTokens
                                            : AppLocalizations.of(context)!
                                                .lpToken,
                                        style: AppTextStyles.bodyLarge(context),
                                      ),
                                  ],
                                ),
                                SelectableText(
                                  '(${percentage.formatNumber(precision: 8)}%)',
                                  style: AppTextStyles.bodyMedium(context),
                                ),
                                if (snapshotBalance.data! > 0)
                                  FutureBuilder<Map<String, dynamic>?>(
                                    future: PoolFactoryRepositoryImpl(
                                      pool!.poolAddress,
                                      aedappfm.sl.get<ApiService>(),
                                    ).getRemoveAmounts(
                                      snapshotBalance.data!,
                                    ),
                                    builder: (
                                      context,
                                      snapshotAmounts,
                                    ) {
                                      if (snapshotAmounts.hasData &&
                                          snapshotAmounts.data != null) {
                                        final amountToken1 = snapshotAmounts
                                                    .data!['token1'] ==
                                                null
                                            ? 0.0
                                            : snapshotAmounts.data!['token1']
                                                as double;
                                        final amountToken2 = snapshotAmounts
                                                    .data!['token2'] ==
                                                null
                                            ? 0.0
                                            : snapshotAmounts.data!['token2']
                                                as double;

                                        return SelectableText(
                                          '${AppLocalizations.of(context)!.poolDetailsInfoDepositedEquivalent} ${amountToken1.formatNumber(precision: amountToken1 > 1 ? 2 : 8)} ${pool!.pair.token1.symbol.reduceSymbol()} / ${amountToken2.formatNumber(precision: amountToken2 > 1 ? 2 : 8)} ${pool!.pair.token2.symbol.reduceSymbol()}',
                                          style:
                                              AppTextStyles.bodyMedium(context),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  )
                                else
                                  SelectableText(
                                    ' ',
                                    style: AppTextStyles.bodyMedium(context),
                                  ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
