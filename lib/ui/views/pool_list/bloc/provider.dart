/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _poolListFormProvider =
    NotifierProvider<PoolListFormNotifier, PoolListFormState>(
  PoolListFormNotifier.new,
);

class PoolListFormNotifier extends Notifier<PoolListFormState> {
  PoolListFormNotifier();

  @override
  PoolListFormState build() => const PoolListFormState();

  void setOnlyVerifiedPools(
    bool onlyVerifiedPools,
  ) {
    state = state.copyWith(
      onlyVerifiedPools: onlyVerifiedPools,
    );
  }

  void setOnlyPoolsWithLiquidityPositions(
    bool onlyPoolsWithLiquidityPositions,
  ) {
    state = state.copyWith(
      onlyPoolsWithLiquidityPositions: onlyPoolsWithLiquidityPositions,
    );
  }
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
}
