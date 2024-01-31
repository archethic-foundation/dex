/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<List<DexPool>> _poolsToDisplay(_PoolsToDisplayRef ref) {
  final poolListFormState = ref.watch(_poolListFormProvider);
  if (poolListFormState.isVerifiedPoolsTabSelected) {
    return ref.watch(DexPoolProviders.verifiedPools.future);
  }

  if (poolListFormState.isMyPoolsTabSelected) {
    return ref.watch(DexPoolProviders.myPools.future);
  }

  if (poolListFormState.isFavoritePoolsTabSelected) {
    return ref.watch(DexPoolProviders.favoritePools.future);
  }

  if (poolListFormState.isAllPoolsTabSelected) {
    return ref.watch(DexPoolProviders.getPoolList.future);
  }

  return ref.watch(
    DexPoolProviders.getPoolListForSearch(
      poolListFormState.searchText,
    ).future,
  );
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
    int tabIndexSelected,
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
  static final poolsToDisplay = _poolsToDisplayProvider;
}
