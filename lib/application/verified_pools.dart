import 'package:aedex/domain/models/verified_pools.dart';
import 'package:aedex/infrastructure/verified_pools_list.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_pools.g.dart';

@Riverpod(keepAlive: true)
VerifiedPoolsRepository _verifiedPoolsRepository(
  _VerifiedPoolsRepositoryRef ref,
) =>
    VerifiedPoolsRepository();

@Riverpod(keepAlive: true)
Future<VerifiedPools> _getVerifiedPools(
  _GetVerifiedPoolsRef ref,
) async {
  final verifiedPools =
      await ref.watch(_verifiedPoolsRepositoryProvider).getVerifiedPools();
  return verifiedPools;
}

@Riverpod(keepAlive: true)
Future<List<String>> _getVerifiedPoolsFromNetwork(
  _GetVerifiedPoolsFromNetworkRef ref,
) async {
  final verifiedPoolsFromNetwork = await ref
      .watch(_verifiedPoolsRepositoryProvider)
      .getVerifiedPoolsFromNetwork();
  return verifiedPoolsFromNetwork;
}

@Riverpod(keepAlive: true)
Future<bool> _isVerifiedPool(
  _IsVerifiedPoolRef ref,
  String address,
) async {
  return ref.watch(_verifiedPoolsRepositoryProvider).isVerifiedPool(address);
}

class VerifiedPoolsRepository {
  Future<VerifiedPools> getVerifiedPools() async {
    return VerifiedPoolsList().getVerifiedPools();
  }

  Future<List<String>> getVerifiedPoolsFromNetwork() async {
    final verifiedPools = await getVerifiedPools();
    final network = EndpointUtil.getEnvironnement();

    switch (network) {
      case 'testnet':
        return verifiedPools.testnet;
      case 'mainnet':
        return verifiedPools.mainnet;
      case 'devnet':
        return verifiedPools.devnet;
      default:
        return [];
    }
  }

  Future<bool> isVerifiedPool(
    String address,
  ) async {
    final verifiedPools = await getVerifiedPoolsFromNetwork();
    if (verifiedPools.contains(address.toUpperCase())) {
      return true;
    }
    return false;
  }
}

abstract class VerifiedPoolsProviders {
  static final getVerifiedPools = _getVerifiedPoolsProvider;
  static const isVerifiedPool = _isVerifiedPoolProvider;
  static final getVerifiedPoolsFromNetwork =
      _getVerifiedPoolsFromNetworkProvider;
}
