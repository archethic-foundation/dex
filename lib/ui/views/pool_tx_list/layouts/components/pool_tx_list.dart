import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/enum/dex_action_type.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool_tx.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/pool_tx_list/layouts/components/pool_tx_single.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PoolTxList extends ConsumerStatefulWidget {
  const PoolTxList({
    super.key,
    required this.pool,
  });

  final DexPool pool;

  @override
  ConsumerState<PoolTxList> createState() => PoolTxListState();
}

class PoolTxListState extends ConsumerState<PoolTxList> {
  List<DexPoolTx>? dexPoolTxList;
  List<DexPoolTx>? filteredTxList;
  bool isLoading = false;
  late ScrollController _scrollController;
  String? lastTransactionAddress;
  String? selectedFilter = 'All';

  final Map<String, DexActionType?> transactionFilters = {
    'All': null,
    'Adds': DexActionType.addLiquidity,
    'Removes': DexActionType.removeLiquidity,
    'Swaps': DexActionType.swap,
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _loadInitialTransactions();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadInitialTransactions() async {
    if (mounted) {
      dexPoolTxList = await _loadMoreTransactions();
      _applyFilter();
      setState(() {});
    }
  }

  Future<List<DexPoolTx>> _loadMoreTransactions() async {
    if (isLoading) return [];
    setState(() {
      isLoading = true;
    });

    final newTransactions = await ref.read(
      DexPoolProviders.getPoolTxList(
        widget.pool,
        lastTransactionAddress ?? '',
      ).future,
    );

    if (newTransactions.isNotEmpty) {
      lastTransactionAddress = newTransactions.last.addressTx;
    }

    setState(() {
      isLoading = false;
    });

    return newTransactions;
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _loadMoreTransactions().then((newTransactions) {
          setState(() {
            dexPoolTxList?.addAll(newTransactions);
            _applyFilter();
          });
        });
      }
    }
  }

  void _applyFilter() {
    final selectedActionType = transactionFilters[selectedFilter];
    if (selectedActionType == null) {
      filteredTxList = dexPoolTxList;
    } else {
      filteredTxList = dexPoolTxList?.where((tx) {
        return tx.typeTx == selectedActionType;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dexPoolTxList == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PoolDetailsInfoHeader(pool: widget.pool),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Pool's Transactions",
                style: AppTextStyles.bodyLarge(context),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            SizedBox(
              height: 310,
              child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemCount: filteredTxList!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == filteredTxList!.length) {
                    return isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: SizedBox(
                                height: 10,
                                width: 10,
                                child:
                                    CircularProgressIndicator(strokeWidth: 1),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  } else {
                    return PoolListSingle(dexPoolTx: filteredTxList![index]);
                  }
                },
              ),
            ),
          ],
        ),
        _buildRatioTokens(context, ref),
      ],
    );
  }

  Widget _buildRatioTokens(BuildContext context, WidgetRef ref) {
    final fiatValueToken1 = ref.watch(
      DexTokensProviders.estimateTokenInFiat(widget.pool.pair.token1.address),
    );
    final fiatValueToken2 = ref.watch(
      DexTokensProviders.estimateTokenInFiat(widget.pool.pair.token2.address),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          fiatValueToken1.when(
            data: (price1) {
              if (price1 > 0) {
                final timestamp = DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(DateTime.now().toLocal());
                return Text(
                  '1 ${widget.pool.pair.token1.symbol} = \$${price1.formatNumber()} ($timestamp)',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
          fiatValueToken2.when(
            data: (price2) {
              if (price2 > 0) {
                final timestamp = DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(DateTime.now().toLocal());
                return Text(
                  '1 ${widget.pool.pair.token2.symbol} = \$${price2.formatNumber()} ($timestamp)',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
