import 'package:aedex/ui/views/pool_tx_list/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _poolTxListFormProvider =
    NotifierProvider.autoDispose<PoolTxListFormNotifier, PoolTxListFormState>(
  () {
    return PoolTxListFormNotifier();
  },
);

class PoolTxListFormNotifier extends AutoDisposeNotifier<PoolTxListFormState> {
  PoolTxListFormNotifier();

  @override
  PoolTxListFormState build() => const PoolTxListFormState();
}

abstract class PoolTxListFormProvider {
  static final poolTxListForm = _poolTxListFormProvider;
}
