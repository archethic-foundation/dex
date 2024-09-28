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
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
FarmLockFormBalances farmLockFormBalances(
  FarmLockFormBalancesRef ref,
) {
  final pool = ref.watch(farmLockFormPoolProvider).value;

  if (pool == null) return const FarmLockFormBalances();

  return FarmLockFormBalances(
    token1Balance: ref
            .watch(
              getBalanceProvider(
                pool.pair.token1.address,
              ),
            )
            .value ??
        0,
    token2Balance: ref
            .watch(
              getBalanceProvider(
                pool.pair.token2.address,
              ),
            )
            .value ??
        0,
    lpTokenBalance: ref
            .watch(
              getBalanceProvider(
                pool.lpToken.address,
              ),
            )
            .value ??
        0,
  );
}

@riverpod
FarmLockFormSummary farmLockFormSummary(
  FarmLockFormSummaryRef ref,
) {
  final farm = ref.watch(farmLockFormFarmProvider).value;
  final farmLock = ref.watch(farmLockFormFarmLockProvider).value;

  if (farm == null || farmLock == null) return const FarmLockFormSummary();

  var capitalInvested = 0.0;
  var rewardsEarned = 0.0;
  var farmedTokensCapitalInFiat = 0.0;
  var price = 0.0;

  farmLock.userInfos.forEach((depositId, userInfos) {
    capitalInvested = capitalInvested + userInfos.amount;
    rewardsEarned = rewardsEarned + userInfos.rewardAmount;
  });

  capitalInvested = capitalInvested + (farm.depositedAmount ?? 0);
  rewardsEarned = rewardsEarned + (farm.rewardAmount ?? 0);

  farmedTokensCapitalInFiat = ref
          .watch(
            DexTokensProviders.estimateLPTokenInFiat(
              farmLock.lpTokenPair!.token1.address,
              farmLock.lpTokenPair!.token2.address,
              capitalInvested,
              farmLock.poolAddress,
            ),
          )
          .value ??
      0;

  price = ref
          .watch(
            DexTokensProviders.estimateTokenInFiat(
              farmLock.rewardToken!.address,
            ),
          )
          .value ??
      0;

  return FarmLockFormSummary(
    farmedTokensCapital: capitalInvested,
    farmedTokensRewards: rewardsEarned,
    farmedTokensCapitalInFiat: farmedTokensCapitalInFiat,
    farmedTokensRewardsInFiat:
        (Decimal.parse('$price') * Decimal.parse('$rewardsEarned')).toDouble(),
  );
}

@riverpod
Future<DexPool?> farmLockFormPool(FarmLockFormPoolRef ref) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(
    DexPoolProviders.getPool(
      environment.aeETHUCOPoolAddress,
    ).future,
  );
}

@riverpod
Future<DexFarm?> farmLockFormFarm(FarmLockFormFarmRef ref) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(
    DexFarmProviders.getFarmInfos(
      environment.aeETHUCOFarmLegacyAddress,
      environment.aeETHUCOPoolAddress,
      dexFarmInput: DexFarm(
        poolAddress: environment.aeETHUCOPoolAddress,
        farmAddress: environment.aeETHUCOFarmLegacyAddress,
      ),
    ).future,
  );
}

@riverpod
Future<DexFarmLock?> farmLockFormFarmLock(
  FarmLockFormFarmLockRef ref,
) {
  final environment = ref.watch(environmentProvider);

  return ref.watch(
    DexFarmLockProviders.getFarmLockInfos(
      environment.aeETHUCOFarmLockAddress,
      environment.aeETHUCOPoolAddress,
      dexFarmLockInput: DexFarmLock(
        poolAddress: environment.aeETHUCOPoolAddress,
        farmAddress: environment.aeETHUCOFarmLockAddress,
      ),
    ).future,
  );
}

@riverpod
Future<List<DexFarmLockUserInfos>> farmLockFormSortedUserFarmLocks(
  FarmLockFormSortedUserFarmLocksRef ref,
  String? sortBy,
  bool? ascending,
) async {
  final farmLock = await ref.watch(
    farmLockFormFarmLockProvider.future,
  );

  final userInfoEntries = farmLock?.userInfos.entries;

  if (userInfoEntries == null) return [];

  final userFarmLocks = userInfoEntries.map((entry) => entry.value).toList();

  if (sortBy == null) {
    return userFarmLocks;
  }
  userFarmLocks.sort((a, b) {
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
    return ascending == true ? compare : -compare;
  });
  return userFarmLocks;
}
