import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmLockFormProvider =
    NotifierProvider.autoDispose<FarmLockFormNotifier, FarmLockFormState>(
  () {
    return FarmLockFormNotifier();
  },
);

class FarmLockFormNotifier extends AutoDisposeNotifier<FarmLockFormState> {
  FarmLockFormNotifier();

  @override
  FarmLockFormState build() => const FarmLockFormState();

  void setPool(DexPool pool) {
    state = state.copyWith(pool: pool);
  }

  void setFarm(DexFarm farm) {
    state = state.copyWith(farm: farm);
  }

  void setMainInfoloadingInProgress(bool mainInfoloadingInProgress) {
    state =
        state.copyWith(mainInfoloadingInProgress: mainInfoloadingInProgress);
  }

  Future<void> calculateSummary() async {
    var capitalInvested = 0.0;
    var rewardsEarned = 0.0;
    var farmedTokensCapitalInFiat = 0.0;
    var price = 0.0;

    final session = ref.read(SessionProviders.session);
    if (session.isConnected == false) {
      state = state.copyWith(
        farmedTokensCapital: 0,
        farmedTokensRewards: 0,
        farmedTokensCapitalInFiat: 0,
        farmedTokensRewardsInFiat: 0,
      );
    }

    if (state.farmLock != null) {
      state.farmLock!.userInfos.forEach((depositId, userInfos) {
        capitalInvested = capitalInvested + userInfos.amount;
        rewardsEarned = rewardsEarned + userInfos.rewardAmount;
      });

      if (state.farm != null) {
        capitalInvested = capitalInvested + (state.farm!.depositedAmount ?? 0);
        rewardsEarned = rewardsEarned + (state.farm!.rewardAmount ?? 0);
      }

      farmedTokensCapitalInFiat = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          state.farmLock!.lpTokenPair!.token1,
          state.farmLock!.lpTokenPair!.token2,
          capitalInvested,
          state.farmLock!.poolAddress,
        ).future,
      );

      price = await ref.read(
        DexTokensProviders.estimateTokenInFiat(state.farmLock!.rewardToken!)
            .future,
      );
    }

    state = state.copyWith(
      farmedTokensCapital: capitalInvested,
      farmedTokensRewards: rewardsEarned,
      farmedTokensCapitalInFiat: farmedTokensCapitalInFiat,
      farmedTokensRewardsInFiat:
          (Decimal.parse('$price') * Decimal.parse('$rewardsEarned'))
              .toDouble(),
    );
  }

  Future<void> setFarmLock(DexFarmLock farmLock) async {
    state = state.copyWith(farmLock: farmLock);
  }

  Future<void> initBalances() async {
    final session = ref.read(SessionProviders.session);

    final token1Balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.pool!.pair.token1.isUCO
            ? 'UCO'
            : state.pool!.pair.token1.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: token1Balance);

    final token2Balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.pool!.pair.token2.isUCO
            ? 'UCO'
            : state.pool!.pair.token2.address!,
      ).future,
    );
    state = state.copyWith(token2Balance: token2Balance);

    final lpTokenBalance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.pool!.lpToken.address!,
      ).future,
    );
    state = state.copyWith(lpTokenBalance: lpTokenBalance);
  }
}

abstract class FarmLockFormProvider {
  static final farmLockForm = _farmLockFormProvider;
}
