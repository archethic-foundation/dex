/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
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
  Future<List<DexPool>> getDexPoolForTab(PoolsListTab currentTab) async {
    switch (currentTab) {
      case PoolsListTab.favoritePools:
        return await ref.read(DexPoolProviders.favoritePools.future);
      case PoolsListTab.verified:
        return await ref.read(DexPoolProviders.verifiedPools.future);
      case PoolsListTab.myPools:
        return await ref.read(DexPoolProviders.myPools.future);
      case PoolsListTab.searchPool:
        final poolListFormState = ref.read(_poolListFormProvider);
        return await ref.read(
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
          await ref.read(DexPoolProviders.getPoolInfos(pool).future);
      poolPopulate = ref.read(
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
  PoolListFormState build() {
    return const PoolListFormState(
      poolsToDisplay: AsyncValue.loading(),
    );
  }

  Future<void> setTabIndexSelected(
    PoolsListTab tabIndexSelected,
  ) async {
    state = state.copyWith(
      tabIndexSelected: tabIndexSelected,
    );
    await setPoolsToDisplay(tabIndexSelected);
  }

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  Future<void> setPoolsToDisplay(
    PoolsListTab poolsListTab,
  ) async {
    state = state.copyWith(
      poolsToDisplay: const AsyncValue.loading(),
    );

    final poolList = await ref.read(
      PoolListFormProvider.poolsToDisplay(
        poolsListTab,
      ).future,
    );
    state = state.copyWith(
      poolsToDisplay: AsyncValue.data(poolList),
    );
  }
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
  static const poolsToDisplay = _poolsToDisplayProvider;
}
