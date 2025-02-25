/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

@riverpod
class PoolListFormNotifier extends _$PoolListFormNotifier {
  PoolListFormNotifier();

  @override
  PoolListFormState build() => const PoolListFormState();

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  void selectTab(PoolsListTab tab) {
    state = state.copyWith(selectedTab: tab);
  }
}

@riverpod
Future<List<DexPool>> poolsToDisplay(Ref ref) async {
  var poolListFiltered = <DexPool>[];
  final selectedTab = ref.watch(
    poolListFormNotifierProvider.select((notifier) => notifier.selectedTab),
  );
  final searchText = ref.watch(
    poolListFormNotifierProvider.select((notifier) => notifier.searchText),
  );
  final poolList = await ref.watch(DexPoolProviders.getPoolList.future);

  switch (selectedTab) {
    case PoolsListTab.favoritePools:
      return [
        for (final pool in poolList)
          if (await ref
              .watch(DexPoolProviders.poolFavorite(pool.poolAddress).future))
            pool,
      ];
    case PoolsListTab.verified:
      return poolList
          .where(
            (element) => element.isVerified,
          )
          .toList();
    case PoolsListTab.myPools:
      final userBalance = await ref.watch(userBalanceProvider.future);
      for (final pool in poolList) {
        var lpTokenInUserBalance = false;

        for (final userTokensBalance in userBalance.token) {
          if (pool.lpToken.address.toUpperCase() ==
              userTokensBalance.address!.toUpperCase()) {
            lpTokenInUserBalance = true;
          }
        }
        if (lpTokenInUserBalance) {
          poolListFiltered.add(pool.copyWith(lpTokenInUserBalance: true));
        }
      }
      return poolListFiltered;
    case PoolsListTab.searchPool:
      poolListFiltered = ref.read(
        DexPoolProviders.getPoolListForSearch(
          searchText,
          poolList,
        ),
      );
      return poolListFiltered;
  }
}
