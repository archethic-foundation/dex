import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/dex_token.repository.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_token.g.dart';

@riverpod
DexTokenRepositoryImpl _dexTokenRepository(_DexTokenRepositoryRef ref) =>
    DexTokenRepositoryImpl(apiService: ref.watch(apiServiceProvider));

@riverpod
Future<DexToken?> _getTokenFromAddress(
  _GetTokenFromAddressRef ref,
  address,
) async {
  return ref.watch(_dexTokenRepositoryProvider).getTokenFromAddress(address);
}

@riverpod
Future<List<DexToken>> _getTokenFromAccount(
  _GetTokenFromAccountRef ref,
  accountAddress,
) async {
  return ref
      .watch(_dexTokenRepositoryProvider)
      .getTokensFromAccount(accountAddress);
}

@riverpod
Future<List<DexToken>> _dexTokenBases(
  _DexTokenBasesRef ref,
) async {
  final repository = ref.watch(_dexTokenRepositoryProvider);
  return repository.getLocalTokensDescriptions();
}

@riverpod
Future<DexToken?> _dexTokenBase(
  _DexTokenBaseRef ref,
  String address,
) async {
  final dexTokens = await ref.watch(_dexTokenBasesProvider.future);
  return dexTokens.firstWhereOrNull(
    (token) => token.address?.toUpperCase() == address.toUpperCase(),
  );
}

@riverpod
Future<String?> _getTokenIcon(
  _GetTokenIconRef ref,
  address,
) async {
  final tokenDescription =
      await ref.watch(_dexTokenBaseProvider(address).future);

  return tokenDescription?.icon;
}

@Riverpod(keepAlive: true)
Future<double> _estimateTokenInFiat(
  _EstimateTokenInFiatRef ref,
  DexToken token,
) async {
  var fiatValue = 0.0;
  if (token.symbol == 'UCO') {
    final archethicOracleUCO =
        ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);

    fiatValue = archethicOracleUCO.usd;
  } else {
    final session = ref.watch(sessionNotifierProvider);
    final price = await ref.watch(
      aedappfm.CoinPriceProviders.coinPrice(
        address: token.address!,
        environment: session.environment,
      ).future,
    );

    fiatValue = price;
  }
  return fiatValue;
}

@Riverpod(keepAlive: true)
Future<double> _estimateLPTokenInFiat(
  _EstimateLPTokenInFiatRef ref,
  DexToken token1,
  DexToken token2,
  double lpTokenAmount,
  String poolAddress,
) async {
  if (lpTokenAmount <= 0) {
    return 0;
  }

  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;

  fiatValueToken1 =
      await ref.watch(DexTokensProviders.estimateTokenInFiat(token1).future);
  fiatValueToken2 =
      await ref.watch(DexTokensProviders.estimateTokenInFiat(token2).future);

  if (fiatValueToken1 == 0 && fiatValueToken2 == 0) {
    throw Exception();
  }

  final apiService = ref.watch(apiServiceProvider);
  final amounts = await PoolFactoryRepositoryImpl(poolAddress, apiService)
      .getRemoveAmounts(lpTokenAmount);
  var amountToken1 = 0.0;
  var amountToken2 = 0.0;
  if (amounts != null) {
    amountToken1 =
        amounts['token1'] == null ? 0.0 : amounts['token1'] as double;
    amountToken2 =
        amounts['token2'] == null ? 0.0 : amounts['token2'] as double;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    return amountToken1 * fiatValueToken1 + amountToken2 * fiatValueToken2;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    return (amountToken1 + amountToken2) * fiatValueToken1;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    return (amountToken1 + amountToken2) * fiatValueToken2;
  }

  return 0;
}

abstract class DexTokensProviders {
  static final tokensCommonBases = _dexTokenBasesProvider;
  static const getTokenFromAddress = _getTokenFromAddressProvider;
  static const getTokenFromAccount = _getTokenFromAccountProvider;
  static const getTokenIcon = _getTokenIconProvider;
  static const estimateTokenInFiat = _estimateTokenInFiatProvider;
  static const estimateLPTokenInFiat = _estimateLPTokenInFiatProvider;
}
