import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_stats.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/infrastructure/dex_farm_lock.repository.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_farm_lock.g.dart';

@riverpod
DexFarmLockRepositoryImpl _dexFarmLockRepository(
  _DexFarmLockRepositoryRef ref,
) =>
    DexFarmLockRepositoryImpl();

@riverpod
Future<DexFarmLock?> _getFarmLockInfos(
  _GetFarmLockInfosRef ref,
  String farmGenesisAddress,
  String poolAddress, {
  DexFarmLock? dexFarmLockInput,
}) async {
  final poolList = await ref.read(DexPoolProviders.getPoolList.future);

  final pool = poolList.firstWhereOrNull(
    (poolSelect) =>
        poolSelect.poolAddress.toUpperCase() == poolAddress.toUpperCase(),
  );
  if (pool == null) return null;

  final userGenesisAddress = ref.read(SessionProviders.session).genesisAddress;
  var farmLockInfos =
      await ref.watch(_dexFarmLockRepositoryProvider).populateFarmLockInfos(
            farmGenesisAddress,
            pool,
            dexFarmLockInput!,
            userGenesisAddress,
          );

  final rewardTokenPriceInFiat = ref.read(
    DexTokensProviders.estimateTokenInFiat(farmLockInfos.rewardToken!),
  );

  final now = DateTime.now().toUtc();

  final newUserInfos = <int, DexFarmLockUserInfos>{};
  for (final entry in farmLockInfos.userInfos.entries) {
    final level = entry.key;
    var userInfos = entry.value;
    var apr = 0.0;
    final estimateLPTokenInFiat = await ref.read(
      DexTokensProviders.estimateLPTokenInFiat(
        farmLockInfos.lpTokenPair!.token1,
        farmLockInfos.lpTokenPair!.token2,
        userInfos.amount,
        dexFarmLockInput.poolAddress,
      ).future,
    );

    final remainingRewardInFiat = (Decimal.parse('$rewardTokenPriceInFiat') *
            Decimal.parse('${farmLockInfos.remainingReward}'))
        .toDouble();

    if (remainingRewardInFiat > 0 &&
        estimateLPTokenInFiat > 0 &&
        farmLockInfos.endDate != null &&
        now.isBefore(farmLockInfos.endDate!)) {
      final secondsUntilEnd = farmLockInfos.endDate!.difference(now).inSeconds;

      if (secondsUntilEnd > 0) {
        // 31 536 000 second in a year
        final rewardScalledToYear =
            remainingRewardInFiat * (31536000 / secondsUntilEnd);

        apr = (Decimal.parse('$rewardScalledToYear') /
                Decimal.parse('$estimateLPTokenInFiat'))
            .toDouble();
        userInfos = userInfos.copyWith(apr: apr);
      }
    }
    newUserInfos[level] = userInfos;

    farmLockInfos = farmLockInfos.copyWith(userInfos: newUserInfos);
  }

  const kLPDepositedPerLevel = 1.0;
  final lpDepositedPerLevelInFiat = await ref.read(
    DexTokensProviders.estimateLPTokenInFiat(
      farmLockInfos.lpTokenPair!.token1,
      farmLockInfos.lpTokenPair!.token2,
      kLPDepositedPerLevel,
      dexFarmLockInput.poolAddress,
    ).future,
  );

  final newStats = <String, DexFarmLockStats>{};

  farmLockInfos.stats.forEach((level, stats) {
    final rewardsAllocatedInFiat =
        stats.rewardsAllocated * rewardTokenPriceInFiat;

    if (lpDepositedPerLevelInFiat > 0) {
      stats = stats.copyWith(
        aprEstimation: rewardsAllocatedInFiat / lpDepositedPerLevelInFiat,
      );
    }
    newStats[level] = stats;
  });
  return farmLockInfos.copyWith(stats: newStats);
}

abstract class DexFarmLockProviders {
  static const getFarmLockInfos = _getFarmLockInfosProvider;
}
