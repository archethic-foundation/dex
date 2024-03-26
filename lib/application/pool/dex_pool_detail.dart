/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<DexPool?> _getPool(
  _GetPoolRef ref,
  String genesisAddress,
) async {
  final tokenVerifiedList = ref
      .read(aedappfm.VerifiedTokensProviders.verifiedTokens)
      .verifiedTokensList;

  return ref
      .read(_dexPoolRepositoryProvider)
      .getPool(genesisAddress, tokenVerifiedList);
}

@riverpod
Future<DexPool?> _getPoolInfos(
  _GetPoolInfosRef ref,
  DexPool poolInput,
) async {
  final poolInfos =
      await ref.watch(_dexPoolRepositoryProvider).populatePoolInfos(poolInput);

  return poolInfos;
}
