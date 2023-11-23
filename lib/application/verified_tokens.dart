import 'package:aedex/domain/models/verified_tokens.dart';
import 'package:aedex/infrastructure/verified_tokens_list.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

@Riverpod(keepAlive: true)
VerifiedTokensRepository _verifiedTokensRepository(
  _VerifiedTokensRepositoryRef ref,
) =>
    VerifiedTokensRepository();

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

class VerifiedTokensRepository {
  Future<VerifiedTokens> getVerifiedTokens() async {
    return VerifiedTokensList().getVerifiedTokens();
  }

  Future<List<String>> getVerifiedTokensFromNetwork() async {
    final verifiedTokens = await getVerifiedTokens();
    final network = EndpointUtil.getEnvironnement();

    switch (network) {
      case 'testnet':
        return verifiedTokens.testnet;
      case 'mainnet':
        return verifiedTokens.mainnet;
      case 'devnet':
        return verifiedTokens.devnet;
      default:
        return [];
    }
  }

  Future<bool> isVerifiedToken(
    String address,
  ) async {
    if (address == 'UCO') {
      return true;
    }
    final verifiedTokens = await getVerifiedTokensFromNetwork();
    if (verifiedTokens.contains(address.toUpperCase())) {
      return true;
    }
    return false;
  }
}

abstract class VerifiedTokensProviders {
  static final getVerifiedTokens = _getVerifiedTokensProvider;
  static const isVerifiedToken = _isVerifiedTokenProvider;
  static final getVerifiedTokensFromNetwork =
      _getVerifiedTokensFromNetworkProvider;
}
