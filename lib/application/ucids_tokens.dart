import 'package:aedex/domain/models/ucids_tokens.dart';
import 'package:aedex/infrastructure/ucids_tokens.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ucids_tokens.g.dart';

@Riverpod(keepAlive: true)
class _UcidsTokensNotifier extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() {
    return {};
  }

  Future<void> init(WidgetRef ref) async {
    state =
        await ref.read(UcidsTokensProviders.getUcidsTokensFromNetwork.future);
  }
}

@Riverpod(keepAlive: true)
UcidsTokensRepositoryImpl _ucidsTokensRepository(
  _UcidsTokensRepositoryRef ref,
) =>
    UcidsTokensRepositoryImpl();

@Riverpod(keepAlive: true)
Future<UcidsTokens> _getUcidsTokens(
  _GetUcidsTokensRef ref,
) async {
  final ucidsTokens =
      await ref.watch(_ucidsTokensRepositoryProvider).getUcidsTokens();
  return ucidsTokens;
}

@Riverpod(keepAlive: true)
Future<Map<String, int>> _getUcidsTokensFromNetwork(
  _GetUcidsTokensFromNetworkRef ref,
) async {
  final ucidsTokensFromNetwork = await ref
      .watch(_ucidsTokensRepositoryProvider)
      .getUcidsTokensFromNetwork();
  return ucidsTokensFromNetwork;
}

@Riverpod(keepAlive: true)
Future<int> _getUcidFromAddress(
  _GetUcidFromAddressRef ref,
  String address,
) async {
  final ucidsTokensFromNetwork = await ref
      .watch(_ucidsTokensRepositoryProvider)
      .getUcidsTokensFromNetwork();

  return ucidsTokensFromNetwork[address] ?? 0;
}

abstract class UcidsTokensProviders {
  static final ucidsTokens = _ucidsTokensNotifierProvider;
  static final getUcidsTokens = _getUcidsTokensProvider;
  static const getUcidFromAddress = _getUcidFromAddressProvider;
  static final getUcidsTokensFromNetwork = _getUcidsTokensFromNetworkProvider;
}
