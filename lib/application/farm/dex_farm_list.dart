/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_farm.dart';

@Riverpod(keepAlive: true)
Future<List<DexFarm>> _getFarmList(
  _GetFarmListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  final dexFarms = <DexFarm>[];
  final poolList = await ref.watch(DexPoolProviders.getPoolList.future);
  final resultFarmList = await RouterFactory(
    dexConf.routerGenesisAddress,
    apiService,
  ).getFarmList(poolList);

  await resultFarmList.map(
    success: (farmList) async {
      for (final farm in farmList) {
        dexFarms.add(farm);
      }
    },
    failure: (failure) {},
  );

  return dexFarms;
}
