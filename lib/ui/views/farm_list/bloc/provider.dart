import 'package:aedex/application/balance.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_list/bloc/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

final _farmListFormProvider =
    AutoDisposeNotifierProvider<FarmListFormNotifier, FarmListFormState>(
  FarmListFormNotifier.new,
);

@riverpod
Future<double> _balance(_BalanceRef ref, String? lpTokenAddress) async {
  final balance = await ref.watch(
    getBalanceProvider(
      lpTokenAddress ?? kUCOAddress,
    ).future,
  );
  return balance;
}

// TODO(Chralu): That provider is weird. Rewrite it and use riverpod generator
class FarmListFormNotifier extends AutoDisposeNotifier<FarmListFormState> {
  FarmListFormNotifier();

  @override
  FarmListFormState build() {
    return const FarmListFormState(
      farmsToDisplay: AsyncValue.loading(),
    );
  }

  void reset() {
    state = state.copyWith(farmsToDisplay: const AsyncValue.data([]));
  }

  Future<void> getFarmsList({
    required String cancelToken,
  }) async {
    state = state.copyWith(
      farmsToDisplay: const AsyncValue.loading(),
      cancelToken: cancelToken,
    );

    final farmList = await ref.read(DexFarmProviders.getFarmList.future);

    if (state.cancelToken == cancelToken) {
      state = state.copyWith(
        farmsToDisplay: AsyncValue.data(farmList),
      );
    }
  }
}

class FarmListFormProvider {
  static const balance = _balanceProvider;
  static final farmListForm = _farmListFormProvider;
}
