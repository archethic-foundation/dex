import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/infrastructure/dex_farm.repository.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_farm.g.dart';
part 'dex_farm_list.dart';

@riverpod
DexFarmRepositoryImpl _dexFarmRepository(_DexFarmRepositoryRef ref) =>
    DexFarmRepositoryImpl();

@riverpod
Future<DexFarm?> _getFarmInfos(
  _GetFarmInfosRef ref,
  String farmGenesisAddress,
  String poolAddress, {
  DexFarm? dexFarmInput,
}) async {
  final poolList = await ref.watch(DexPoolProviders.getPoolList.future);

  final pool = poolList.firstWhereOrNull(
    (poolSelect) =>
        poolSelect.poolAddress.toUpperCase() == poolAddress.toUpperCase(),
  );
  if (pool == null) return null;

  final farmInfos =
      await ref.watch(_dexFarmRepositoryProvider).populateFarmInfos(
            farmGenesisAddress,
            pool,
            dexFarmInput!,
          );

  var apr = 0.0;
  final estimateLPTokenInFiat = await ref.watch(
    DexTokensProviders.estimateLPTokenInFiat(
      farmInfos.lpTokenPair!.token1,
      farmInfos.lpTokenPair!.token2,
      farmInfos.lpTokenDeposited,
      dexFarmInput.poolAddress,
    ).future,
  );
  final now = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).truncate();

  final priceTokenInFiat =
      ref.watch(DexTokensProviders.estimateTokenInFiat(farmInfos.rewardToken!));

  final remainingRewardInFiat = (Decimal.parse('$priceTokenInFiat') *
          Decimal.parse('${farmInfos.remainingReward}'))
      .toDouble();

  if (remainingRewardInFiat > 0 &&
      estimateLPTokenInFiat > 0 &&
      now < dexFarmInput.endDate) {
    // 31 536 000 second in a year
    final rewardScalledToYear =
        remainingRewardInFiat * (31536000 / (dexFarmInput.endDate - now));

    apr = (Decimal.parse('$rewardScalledToYear') /
            Decimal.parse('$estimateLPTokenInFiat'))
        .toDouble();
  }

  return farmInfos.copyWith(
    estimateLPTokenInFiat: estimateLPTokenInFiat,
    remainingRewardInFiat: remainingRewardInFiat,
    apr: apr,
  );
}

@riverpod
Future<DexFarmUserInfos?> _getUserInfos(
  _GetUserInfosRef ref,
  String farmGenesisAddress,
  String userGenesisAddress,
) async {
  final farmInfos = await ref
      .watch(_dexFarmRepositoryProvider)
      .getUserInfos(farmGenesisAddress, userGenesisAddress);

  return farmInfos;
}

abstract class DexFarmProviders {
  static final getFarmList = _getFarmListProvider;
  static const getFarmInfos = _getFarmInfosProvider;
  static const getUserInfos = _getUserInfosProvider;
}
