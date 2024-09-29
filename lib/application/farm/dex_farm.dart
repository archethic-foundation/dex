import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/infrastructure/dex_farm.repository.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_farm.g.dart';
part 'dex_farm_list.dart';

@riverpod
DexFarmRepositoryImpl _dexFarmRepository(_DexFarmRepositoryRef ref) =>
    DexFarmRepositoryImpl(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(
        verifiedTokensRepositoryProvider,
      ),
    );

@riverpod
Future<DexFarm?> _getFarmInfos(
  _GetFarmInfosRef ref,
  String farmGenesisAddress,
  String poolAddress, {
  DexFarm? dexFarmInput,
}) async {
  final poolList = await ref.watch(DexPoolProviders.getPoolList.future);
  final userGenesisAddress = ref.watch(sessionNotifierProvider).genesisAddress;
  final dexFarmRepository = ref.watch(_dexFarmRepositoryProvider);

  final pool = poolList.firstWhereOrNull(
    (poolSelect) =>
        poolSelect.poolAddress.toUpperCase() == poolAddress.toUpperCase(),
  );
  if (pool == null) return null;

  final farmInfos = await dexFarmRepository.populateFarmInfos(
    farmGenesisAddress,
    pool,
    dexFarmInput!,
    userGenesisAddress,
  );

  var apr = 0.0;
  final estimateLPTokenInFiat = await ref.watch(
    DexTokensProviders.estimateLPTokenInFiat(
      farmInfos.lpTokenPair!.token1.address,
      farmInfos.lpTokenPair!.token2.address,
      farmInfos.lpTokenDeposited,
      dexFarmInput.poolAddress,
    ).future,
  );
  final now = DateTime.now().toUtc();

  final priceTokenInFiat = await ref.read(
    DexTokensProviders.estimateTokenInFiat(farmInfos.rewardToken!.address)
        .future,
  );

  final remainingRewardInFiat = (Decimal.parse('$priceTokenInFiat') *
          Decimal.parse('${farmInfos.remainingReward}'))
      .toDouble();

  if (remainingRewardInFiat > 0 &&
      estimateLPTokenInFiat > 0 &&
      farmInfos.endDate != null &&
      now.isBefore(farmInfos.endDate!)) {
    final secondsUntilEnd = farmInfos.endDate!.difference(now).inSeconds;

    if (secondsUntilEnd > 0) {
      // 31 536 000 second in a year
      final rewardScalledToYear =
          remainingRewardInFiat * (31536000 / secondsUntilEnd);

      apr = (Decimal.parse('$rewardScalledToYear') /
              Decimal.parse('$estimateLPTokenInFiat'))
          .toDouble();
    }
  }

  return farmInfos.copyWith(
    estimateLPTokenInFiat: estimateLPTokenInFiat,
    remainingRewardInFiat: remainingRewardInFiat,
    apr: apr,
  );
}

abstract class DexFarmProviders {
  static final getFarmList = _getFarmListProvider;
  static const getFarmInfos = _getFarmInfosProvider;
}
