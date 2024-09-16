import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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
    var _tempState = const FarmLockFormState();
    try {
      _tempState = _tempState.copyWith(mainInfoloadingInProgress: true);

      final session = await ref.read(sessionNotifierProvider.future);

      _tempState = _tempState.copyWith(
        pool: session.aeETHUCOPool,
        farm: session.aeETHUCOFarm,
        farmLock: session.aeETHUCOFarmLock,
      );

      if (session.aeETHUCOFarmLock != null) {
        _tempState = await _calculateSummary(_tempState);
        _tempState = await _initBalances(_tempState);
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
  ) async {
    var capitalInvested = 0.0;
    var rewardsEarned = 0.0;
    var farmedTokensCapitalInFiat = 0.0;
    var price = 0.0;

    final session = ref.read(sessionNotifierProvider).value ?? const Session();
    if (session.isConnected == false) {
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
          state.farmLock!.lpTokenPair!.token1,
          state.farmLock!.lpTokenPair!.token2,
          capitalInvested,
          state.farmLock!.poolAddress,
        ).future,
      );

      price = await ref.watch(
        DexTokensProviders.estimateTokenInFiat(state.farmLock!.rewardToken!)
            .future,
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

  Future<FarmLockFormState> _initBalances(FarmLockFormState state) async {
    final session = ref.read(sessionNotifierProvider).value ?? const Session();
    final apiService = aedappfm.sl.get<ApiService>();
    if (session.isConnected == false) {
      return state.copyWith(
        token1Balance: 0,
        token2Balance: 0,
        lpTokenBalance: 0,
      );
    }

    final token1BalanceFuture = ref.read(
      getBalanceProvider(
        session.genesisAddress,
        state.pool!.pair.token1.isUCO
            ? 'UCO'
            : state.pool!.pair.token1.address!,
        apiService,
      ).future,
    );

    final token2BalanceFuture = ref.read(
      getBalanceProvider(
        session.genesisAddress,
        state.pool!.pair.token2.isUCO
            ? 'UCO'
            : state.pool!.pair.token2.address!,
        apiService,
      ).future,
    );

    final lpTokenBalanceFuture = ref.read(
      getBalanceProvider(
        session.genesisAddress,
        state.pool!.lpToken.address!,
        apiService,
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
    bool invertSort,
    List<DexFarmLockUserInfos> sortedUserInfos,
  ) {
    if (invertSort) {
      sortAscending[sortBy] = !sortAscending[sortBy]!;
    }
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
