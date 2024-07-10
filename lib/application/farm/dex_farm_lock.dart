import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/infrastructure/dex_farm_lock.repository.dart';
import 'package:collection/collection.dart';
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

    /*
    // Récupérer les rewards alloués pour l'année en cours et ramener au temps restant
    final newUserInfos = <int, DexFarmLockUserInfos>{};
    for (final entry in farmLockInfos.userInfos.entries) {
      final index = entry.key;
      var userInfos = entry.value;

      final rewardsdInFiat = userInfos.rewardAmount * rewardTokenPriceInFiat;

      final lpAmountInFiat = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          farmLockInfos.lpTokenPair!.token1,
          farmLockInfos.lpTokenPair!.token2,
          userInfos.amount,
          dexFarmLockInput.poolAddress,
        ).future,
      );

      if (lpAmountInFiat > 0) {
        userInfos = userInfos.copyWith(
          apr: (Decimal.parse('$rewardsdInFiat') /
                  Decimal.parse('$lpAmountInFiat'))
              .toDouble(),
        );
      }
      newUserInfos[index] = userInfos;
    }*/

    /*  final newStats = <String, DexFarmLockStats>{};
    for (final entry in farmLockInfos.stats.entries) {
      final level = entry.key;
      var stats = entry.value;

      final rewardsAllocatedInFiat =
          stats.rewardsAllocated * rewardTokenPriceInFiat;

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

    return farmLockInfos.copyWith(stats: newStats);*/
    return farmLockInfos;
  } catch (e) {
    return null;
  }
}

abstract class DexFarmLockProviders {
  static const getFarmLockInfos = _getFarmLockInfosProvider;
}
