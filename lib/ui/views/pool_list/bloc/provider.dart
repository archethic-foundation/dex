/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_list/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _poolListFormProvider =
    NotifierProvider.autoDispose<PoolListFormNotifier, PoolListFormState>(
  () {
    return PoolListFormNotifier();
  },
);

class PoolListFormNotifier extends AutoDisposeNotifier<PoolListFormState> {
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
}

abstract class PoolListFormProvider {
  static final poolListForm = _poolListFormProvider;
}
