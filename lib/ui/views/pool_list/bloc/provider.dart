/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

enum PoolsListTab { verified, myPools, favoritePools, allPools, searchPool }

@riverpod
Future<List<DexPool>> _poolsToDisplay(
  _PoolsToDisplayRef ref,
  PoolsListTab currentTab,
) async {
  Future<List<DexPool>> getDexPoolForTab(PoolsListTab currentTab) {
    switch (currentTab) {
      case PoolsListTab.allPools:
        return ref.watch(DexPoolProviders.getPoolList.future);
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
  for (final pool in poolList) {
    if (pool.infos == null) {
      final poolPopulate =
          await ref.watch(DexPoolProviders.getPoolInfos(pool).future);
      finalPoolsList.add(poolPopulate!);
    } else {
      finalPoolsList.add(pool);
    }
  }

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
