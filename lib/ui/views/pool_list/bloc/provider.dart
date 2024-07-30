/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/hive/favorite_pools.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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

final _searchTextProvider = StateProvider<String>((ref) => '');

final _selectedTabProvider =
    StateProvider<PoolsListTab>((ref) => PoolsListTab.verified);

@riverpod
Future<List<DexPool>> _poolsList(
  _PoolsListRef ref,
  PoolsListTab selectedTab,
) async {
  final poolList = await ref.watch(DexPoolProviders.getPoolList.future);

  switch (selectedTab) {
    case PoolsListTab.favoritePools:
      final favoritePoolsDatasource =
          await HiveFavoritePoolsDatasource.getInstance();
      return poolList.where((element) {
        return favoritePoolsDatasource.isFavoritePool(
          aedappfm.EndpointUtil.getEnvironnement(),
          element.poolAddress,
        );
      }).toList();
    case PoolsListTab.verified:
      return poolList
          .where(
            (element) => element.isVerified,
          )
          .toList();
    case PoolsListTab.myPools:
      final userBalance = ref
          .watch(SessionProviders.session.select((value) => value.userBalance));
      if (userBalance == null) return [];

      return poolList
          .where(
            (pool) {
              return userBalance.token.any(
                (userTokensBalance) {
                  return pool.lpToken.address!.toUpperCase() ==
                      userTokensBalance.address!.toUpperCase();
                },
              );
            },
          )
          .map((pool) => pool.copyWith(lpTokenInUserBalance: true))
          .toList();
    case PoolsListTab.searchPool:
      return ref.watch(
        DexPoolProviders.getPoolListForSearch(
          ref.watch(_searchTextProvider),
          poolList,
        ),
      );
  }
}

abstract class PoolListFormProvider {
  static final searchText = _searchTextProvider;
  static final selectedTab = _selectedTabProvider;
  static const pools = _poolsListProvider;
}
