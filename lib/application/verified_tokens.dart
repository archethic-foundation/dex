import 'package:aedex/domain/models/verified_tokens.dart';
import 'package:aedex/infrastructure/verified_tokens.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

@Riverpod(keepAlive: true)
VerifiedTokensRepositoryImpl _verifiedTokensRepository(
  _VerifiedTokensRepositoryRef ref,
) =>
    VerifiedTokensRepositoryImpl();

@Riverpod(keepAlive: true)
Future<VerifiedTokens> _getVerifiedTokens(
  _GetVerifiedTokensRef ref,
) async {
  final verifiedTokens =
      await ref.watch(_verifiedTokensRepositoryProvider).getVerifiedTokens();
  return verifiedTokens;
}

@Riverpod(keepAlive: true)
Future<List<String>> _getVerifiedTokensFromNetwork(
  _GetVerifiedTokensFromNetworkRef ref,
) async {
  final verifiedTokensFromNetwork = await ref
      .watch(_verifiedTokensRepositoryProvider)
      .getVerifiedTokensFromNetwork();
  return verifiedTokensFromNetwork;
}

@Riverpod(keepAlive: true)
Future<bool> _isVerifiedToken(
  _IsVerifiedTokenRef ref,
  String address,
) async {
  return ref.watch(_verifiedTokensRepositoryProvider).isVerifiedToken(address);
}

abstract class VerifiedTokensProviders {
  static final getVerifiedTokens = _getVerifiedTokensProvider;
  static const isVerifiedToken = _isVerifiedTokenProvider;
  static final getVerifiedTokensFromNetwork =
      _getVerifiedTokensFromNetworkProvider;
}
