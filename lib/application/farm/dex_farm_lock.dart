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
  try {
    final farmLockInfos =
        await ref.read(_dexFarmLockRepositoryProvider).populateFarmLockInfos(
              farmGenesisAddress,
              pool,
              dexFarmLockInput!,
              userGenesisAddress,
            );

    final rewardTokenPriceInFiat = ref.read(
      DexTokensProviders.estimateTokenInFiat(farmLockInfos.rewardToken!),
    );

    final now = DateTime.now().toUtc();

    int _getCurrentYearInPeriod(DateTime startDate) {
      final yearsDifference = now.year - startDate.year;
      var currentYearInPeriod = yearsDifference % 4 + 1;

      if (now.month < startDate.month ||
          (now.month == startDate.month && now.day < startDate.day)) {
        currentYearInPeriod--;
        if (currentYearInPeriod == 0) {
          currentYearInPeriod = 4;
        }
      }

      return currentYearInPeriod;
    }

    DateTime _addYears(DateTime date, int years) {
      return DateTime(date.year + years, date.month, date.day);
    }

    final currentYearInPeriod =
        _getCurrentYearInPeriod(farmLockInfos.startDate!);

    final secondsUntilEnd =
        _addYears(farmLockInfos.startDate!, currentYearInPeriod)
            .difference(now)
            .inSeconds;
    if (rewardTokenPriceInFiat == 0 ||
        farmLockInfos.isOpen == false ||
        secondsUntilEnd <= 0) {
      return farmLockInfos;
    }

    // Estimation APR for each period
    final newStats = <String, DexFarmLockStats>{};
    for (final entry in farmLockInfos.stats.entries) {
      final level = entry.key;
      var stats = entry.value;

      final rewardsAllocatedInFiat =
          stats.rewardsAllocated.entries.first.value * rewardTokenPriceInFiat;

      final lpDepositedPerLevelInFiat = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          farmLockInfos.lpTokenPair!.token1,
          farmLockInfos.lpTokenPair!.token2,
          stats.lpTokensDeposited,
          dexFarmLockInput.poolAddress,
        ).future,
      );

      if (lpDepositedPerLevelInFiat > 0) {
        stats = stats.copyWith(
          aprEstimation: (Decimal.parse('$rewardsAllocatedInFiat') /
                  Decimal.parse('$lpDepositedPerLevelInFiat'))
              .toDouble(),
        );
      }
      newStats[level] = stats;
    }

    // APR for each lock
    final newUserInfos = <int, DexFarmLockUserInfos>{};
    for (final entry in farmLockInfos.userInfos.entries) {
      final index = entry.key;
      var userInfos = entry.value;

      final rewardsdInFiat = (newStats[userInfos.level]!
                  .rewardsAllocated[currentYearInPeriod.toString()] ??
              0.0) *
          rewardTokenPriceInFiat;

      final lpTokenDepositedInFiat = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          farmLockInfos.lpTokenPair!.token1,
          farmLockInfos.lpTokenPair!.token2,
          newStats[userInfos.level]!.lpTokensDeposited,
          dexFarmLockInput.poolAddress,
        ).future,
      );

      if (lpTokenDepositedInFiat > 0) {
        // 31 536 000 second in a year
        final rewardScalledToYear =
            rewardsdInFiat * (31536000 / secondsUntilEnd);

        userInfos = userInfos.copyWith(
          apr: (Decimal.parse('$rewardScalledToYear') /
                  Decimal.parse('$lpTokenDepositedInFiat'))
              .toDouble(),
        );
      }
      newUserInfos[index] = userInfos;
    }

    return farmLockInfos.copyWith(stats: newStats, userInfos: newUserInfos);
  } catch (e) {
    return null;
  }
}

abstract class DexFarmLockProviders {
  static const getFarmLockInfos = _getFarmLockInfosProvider;
}
