import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:decimal/decimal.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

Map<String, bool> sortAscending = {
  'amount': true,
  'rewards': true,
  'unlocks_in': true,
  'level': false,
  'apr': true,
};

@riverpod
class FarmLockFormNotifier extends _$FarmLockFormNotifier {
  FarmLockFormNotifier();

  static final _logger = Logger('FarmLockFormNotifier');

  @override
  Future<FarmLockFormState> build() async {
    final isConnected = ref.watch(
      sessionNotifierProvider.select((session) => session.isConnected),
    );
    final environment = ref.watch(environmentProvider);

    final pool = await ref.watch(
      DexPoolProviders.getPool(
        environment.aeETHUCOPoolAddress,
      ).future,
    );

    final farm = await ref.watch(
      DexFarmProviders.getFarmInfos(
        environment.aeETHUCOFarmLegacyAddress,
        environment.aeETHUCOPoolAddress,
        dexFarmInput: DexFarm(
          poolAddress: environment.aeETHUCOPoolAddress,
          farmAddress: environment.aeETHUCOFarmLegacyAddress,
        ),
      ).future,
    );

    final farmLock = await ref.watch(
      DexFarmLockProviders.getFarmLockInfos(
        environment.aeETHUCOFarmLockAddress,
        environment.aeETHUCOPoolAddress,
        dexFarmLockInput: DexFarmLock(
          poolAddress: environment.aeETHUCOPoolAddress,
          farmAddress: environment.aeETHUCOFarmLockAddress,
        ),
      ).future,
    );

    var _tempState = const FarmLockFormState();
    try {
      // TODO(Chralu): [mainInfoloadingInProgress] is useless : provider state alredy indicates if it is loading.
      _tempState = _tempState.copyWith(mainInfoloadingInProgress: true);

      _tempState = _tempState.copyWith(
        pool: pool,
        farm: farm,
        farmLock: farmLock,
      );

      if (farmLock != null) {
        _tempState = await _calculateSummary(_tempState, isConnected);
        _tempState = await _initBalances(_tempState, isConnected);
      }
      return _tempState.copyWith(mainInfoloadingInProgress: false);
    } catch (e) {
      _logger.warning(
        '$e',
      );
      return _tempState.copyWith(mainInfoloadingInProgress: false);
    }
  }

  Future<FarmLockFormState> _calculateSummary(
    FarmLockFormState state,
    bool isConnected,
  ) async {
    var capitalInvested = 0.0;
    var rewardsEarned = 0.0;
    var farmedTokensCapitalInFiat = 0.0;
    var price = 0.0;

    if (isConnected == false) {
      return state.copyWith(
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

      farmedTokensCapitalInFiat = await ref.watch(
        DexTokensProviders.estimateLPTokenInFiat(
          state.farmLock!.lpTokenPair!.token1.address,
          state.farmLock!.lpTokenPair!.token2.address,
          capitalInvested,
          state.farmLock!.poolAddress,
        ).future,
      );

      price = await ref.watch(
        DexTokensProviders.estimateTokenInFiat(
          state.farmLock!.rewardToken!.address,
        ).future,
      );
    }

    return state.copyWith(
      farmedTokensCapital: capitalInvested,
      farmedTokensRewards: rewardsEarned,
      farmedTokensCapitalInFiat: farmedTokensCapitalInFiat,
      farmedTokensRewardsInFiat:
          (Decimal.parse('$price') * Decimal.parse('$rewardsEarned'))
              .toDouble(),
    );
  }

  Future<FarmLockFormState> _initBalances(
    FarmLockFormState state,
    bool isConnected,
  ) async {
    if (isConnected == false) {
      return state.copyWith(
        token1Balance: 0,
        token2Balance: 0,
        lpTokenBalance: 0,
      );
    }

    final token1BalanceFuture = ref.watch(
      getBalanceProvider(
        state.pool!.pair.token1.address,
      ).future,
    );

    final token2BalanceFuture = ref.watch(
      getBalanceProvider(
        state.pool!.pair.token2.address,
      ).future,
    );

    final lpTokenBalanceFuture = ref.watch(
      getBalanceProvider(
        state.pool!.lpToken.address,
      ).future,
    );

    final results = await Future.wait([
      token1BalanceFuture,
      token2BalanceFuture,
      lpTokenBalanceFuture,
    ]);

    final token1Balance = results[0] as double?;
    final token2Balance = results[1] as double?;
    final lpTokenBalance = results[2] as double?;

    return state.copyWith(
      token1Balance: token1Balance ?? 0,
      token2Balance: token2Balance ?? 0,
      lpTokenBalance: lpTokenBalance ?? 0,
    );
  }

  List<DexFarmLockUserInfos> sortData(
    String sortBy,
    List<DexFarmLockUserInfos> sortedUserInfos,
  ) {
    sortAscending[sortBy] = !sortAscending[sortBy]!;
    final ascending = sortAscending[sortBy]!;
    sortedUserInfos.sort((a, b) {
      int compare;
      switch (sortBy) {
        case 'amount':
          compare = a.amount.compareTo(b.amount);
          break;
        case 'rewards':
          compare = a.rewardAmount.compareTo(b.rewardAmount);
          break;
        case 'unlocks_in':
          if (a.end == null && b.end == null) {
            compare = 0;
          } else if (a.end == null) {
            compare = 1;
          } else if (b.end == null) {
            compare = -1;
          } else {
            compare = a.end!.compareTo(b.end!);
          }
          break;
        case 'level':
          compare = a.level.compareTo(b.level);
          break;
        case 'apr':
          compare = a.apr.compareTo(b.apr);
          break;
        default:
          compare = 0;
      }
      return ascending ? compare : -compare;
    });

    return sortedUserInfos;
  }
}
