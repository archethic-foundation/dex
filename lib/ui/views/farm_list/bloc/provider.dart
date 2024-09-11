import 'package:aedex/application/balance.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

final _farmListFormProvider =
    AutoDisposeNotifierProvider<FarmListFormNotifier, FarmListFormState>(
  FarmListFormNotifier.new,
);

@riverpod
Future<double> _balance(_BalanceRef ref, String? lpTokenAddress) async {
  final session = ref.watch(SessionProviders.session);
  final apiService = aedappfm.sl.get<archethic.ApiService>();
  final balance = await ref.watch(
    BalanceProviders.getBalance(
      session.genesisAddress,
      lpTokenAddress == 'UCO' || lpTokenAddress == null
          ? 'UCO'
          : lpTokenAddress,
      apiService,
    ).future,
  );
  return balance;
}

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
