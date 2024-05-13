/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/hive/favorite_pools.hive.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum PoolsListTab {
  verified(true),
  myPools(true),
  favoritePools(true),
  searchPool(false);

  const PoolsListTab(this.skipLoadingOnReload);
  final bool skipLoadingOnReload;
}

PoolsListTab poolsListTabFromJson(String json) {
  switch (json) {
    case 'verified':
      return PoolsListTab.verified;
    case 'myPools':
      return PoolsListTab.myPools;
    case 'favoritePools':
      return PoolsListTab.favoritePools;
    case 'searchPool':
      return PoolsListTab.searchPool;
    default:
      throw Exception('Unknown PoolsListTab value: $json');
  }
}

final _poolListFormProvider =
    AutoDisposeNotifierProvider<PoolListFormNotifier, PoolListFormState>(
  PoolListFormNotifier.new,
);

class PoolListFormNotifier extends AutoDisposeNotifier<PoolListFormState> {
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

  Future<void> getPoolsList({
    required PoolsListTab tabIndexSelected,
    required String cancelToken,
  }) async {
    state = state.copyWith(
      tabIndexSelected: tabIndexSelected,
      poolsToDisplay: const AsyncValue.loading(),
      cancelToken: cancelToken,
    );

    var poolListFiltered = <DexPool>[];
    final poolList = await ref.read(DexPoolProviders.getPoolList.future);

    switch (tabIndexSelected) {
      case PoolsListTab.favoritePools:
        final favoritePoolsDatasource =
            await HiveFavoritePoolsDatasource.getInstance();
        poolListFiltered = poolList.where((element) {
          return favoritePoolsDatasource.isFavoritePool(
            aedappfm.EndpointUtil.getEnvironnement(),
            element.poolAddress,
          );
        }).toList();
        break;
      case PoolsListTab.verified:
        poolListFiltered = poolList
            .where(
              (element) => element.isVerified,
            )
            .toList();
        break;
      case PoolsListTab.myPools:
        final userBalance = ref.read(SessionProviders.session).userBalance;
        if (userBalance != null) {
          for (final pool in poolList) {
            var lpTokenInUserBalance = false;
            for (final userTokensBalance in userBalance.token) {
              if (pool.lpToken.address!.toUpperCase() ==
                  userTokensBalance.address!.toUpperCase()) {
                lpTokenInUserBalance = true;
              }
            }
            if (lpTokenInUserBalance) {
              poolListFiltered.add(pool.copyWith(lpTokenInUserBalance: true));
            }
          }
        }
        break;
      case PoolsListTab.searchPool:
        poolListFiltered = ref.read(
          DexPoolProviders.getPoolListForSearch(
            state.searchText,
            poolList,
          ),
        );
        break;
    }

    if (state.cancelToken == cancelToken) {
      state = state.copyWith(
        poolsToDisplay: AsyncValue.data(poolListFiltered),
      );
    }
  }
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
}
