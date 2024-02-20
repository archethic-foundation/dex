import 'package:aedex/application/balance.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<DexFarmUserInfos> _userInfos(
  _UserInfosRef ref,
  String farmAddress,
) async {
  final session = ref.watch(SessionProviders.session);

  final userInfos = await ref.watch(
    DexFarmProviders.getUserInfos(
      farmAddress,
      session.genesisAddress,
    ).future,
  );
  return userInfos!;
}

@riverpod
Future<double> _balance(_BalanceRef ref, String? lpTokenAddress) async {
  final session = ref.watch(SessionProviders.session);
  final balance = await ref.watch(
    BalanceProviders.getBalance(
      session.genesisAddress,
      lpTokenAddress == 'UCO' || lpTokenAddress == null
          ? 'UCO'
          : lpTokenAddress,
    ).future,
  );
  return balance;
}

class FarmListProvider {
  static const userInfos = _userInfosProvider;
  static const balance = _balanceProvider;
}
