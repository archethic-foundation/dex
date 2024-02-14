/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

enum PoolsListTab {
  verified(true),
  myPools(true),
  favoritePools(true),
  searchPool(false);

  const PoolsListTab(this.skipLoadingOnReload);
  final bool skipLoadingOnReload;
}

@riverpod
Future<List<DexPool>> _poolsToDisplay(
  _PoolsToDisplayRef ref,
  PoolsListTab currentTab,
) async {
  Future<List<DexPool>> getDexPoolForTab(PoolsListTab currentTab) {
    switch (currentTab) {
      case PoolsListTab.favoritePools:
        return ref.watch(DexPoolProviders.favoritePools.future);
      case PoolsListTab.verified:
        return ref.watch(DexPoolProviders.verifiedPools.future);
      case PoolsListTab.myPools:
        return ref.watch(DexPoolProviders.myPools.future);
      case PoolsListTab.searchPool:
        final poolListFormState = ref.watch(_poolListFormProvider);
        return ref.watch(
          DexPoolProviders.getPoolListForSearch(
            poolListFormState.searchText,
          ).future,
        );
    }
  }

  final poolList = await getDexPoolForTab(currentTab);

  final finalPoolsList = <DexPool>[];

  final fromCriteria =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final tx24hAddress = <String, String>{};
  for (final pool in poolList) {
    if (pool.infos == null) {
      tx24hAddress[pool.poolAddress] = '';
    }
  }

  final transactionChainResult =
      await aedappfm.sl.get<ApiService>().getTransactionChain(
            tx24hAddress,
            request:
                ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
            fromCriteria: fromCriteria,
          );

  for (final pool in poolList) {
    if (pool.infos == null) {
      var poolPopulate =
          await ref.watch(DexPoolProviders.getPoolInfos(pool).future);
      poolPopulate = ref.watch(
        DexPoolProviders.populatePoolInfosWithTokenStats24h(
          poolPopulate!,
          transactionChainResult,
        ),
      );
      finalPoolsList.add(poolPopulate!);
    } else {
      finalPoolsList.add(pool);
    }
  }

  finalPoolsList.sort(
    (a, b) => a.pair.token1.symbol
        .toUpperCase()
        .compareTo(b.pair.token1.symbol.toUpperCase()),
  );
  return finalPoolsList;
}

final _poolListFormProvider =
    NotifierProvider<PoolListFormNotifier, PoolListFormState>(
  PoolListFormNotifier.new,
);

class PoolListFormNotifier extends Notifier<PoolListFormState> {
  PoolListFormNotifier();

  @override
  PoolListFormState build() => const PoolListFormState();

  void setTabIndexSelected(
    PoolsListTab tabIndexSelected,
  ) {
    state = state.copyWith(
      tabIndexSelected: tabIndexSelected,
    );
  }

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
  static const poolsToDisplay = _poolsToDisplayProvider;
}
