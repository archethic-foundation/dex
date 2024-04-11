/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/pool.repository.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum PoolsListTab {
  verified(true),
  myPools(true),
  favoritePools(true),
  searchPool(false);

  const PoolsListTab(this.skipLoadingOnReload);
  final bool skipLoadingOnReload;
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

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  Future<List<DexPool>> getDexPoolForTab(
    PoolsListTab currentTab,
    String? searchText,
  ) async {
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();
    switch (currentTab) {
      case PoolsListTab.favoritePools:
        return poolsListDatasource
            .getPoolsList()
            .map(
              (hiveObject) => hiveObject.toDexPool(),
            )
            .where(
              (element) => element.isFavorite,
            )
            .toList();
      case PoolsListTab.verified:
        return poolsListDatasource
            .getPoolsList()
            .map(
              (hiveObject) => hiveObject.toDexPool(),
            )
            .where(
              (element) => element.isVerified,
            )
            .toList();
      case PoolsListTab.myPools:
        return poolsListDatasource
            .getPoolsList()
            .map(
              (hiveObject) => hiveObject.toDexPool(),
            )
            .where(
              (element) => element.lpTokenInUserBalance,
            )
            .toList();
      case PoolsListTab.searchPool:
        final poolList = await ref.read(DexPoolProviders.getPoolList.future);
        return ref.read(
          DexPoolProviders.getPoolListForSearch(
            searchText ?? '',
            poolList,
          ),
        );
    }
  }

  Future<void> setPoolsToDisplay({
    required PoolsListTab tabIndexSelected,
    required String cancelToken,
  }) async {
    state = state.copyWith(
      tabIndexSelected: tabIndexSelected,
      poolsToDisplay: const AsyncValue.loading(),
      cancelToken: cancelToken,
    );

    final poolList = await getDexPoolForTab(tabIndexSelected, state.searchText);

    final finalPoolsList = <DexPool>[];

    final fromCriteria = (DateTime.now()
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch /
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

    final poolsWithoutInfos = <DexPool>[];

    for (final pool in poolList) {
      if (pool.infos == null) {
        poolsWithoutInfos.add(pool);
      } else {
        finalPoolsList.add(pool);
      }
    }

    if (poolsWithoutInfos.isNotEmpty) {
      final apiService = aedappfm.sl.get<ApiService>();
      final poolListWithInfos = await PoolRepositoryImpl(apiService)
          .getPoolInfosBatch(poolsWithoutInfos);
      for (final poolWithInfos in poolListWithInfos) {
        final poolPopulate = ref.read(
          DexPoolProviders.populatePoolInfosWithTokenStats24h(
            poolWithInfos,
            transactionChainResult,
          ),
        );
        finalPoolsList.add(poolPopulate);
      }
    }

    if (state.cancelToken == cancelToken) {
      state = state.copyWith(
        poolsToDisplay: AsyncValue.data(finalPoolsList),
      );
    }
  }
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
}
