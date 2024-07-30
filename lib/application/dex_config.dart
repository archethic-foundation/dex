/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_config.dart';
import 'package:aedex/domain/repositories/dex_config.repository.dart';
import 'package:aedex/infrastructure/dex_config.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_config.g.dart';

@Riverpod(keepAlive: true)
DexConfigRepository _dexConfigRepository(
  _DexConfigRepositoryRef ref,
) =>
    DexConfigRepositoryImpl();

@riverpod
Future<DexConfig> _dexConfig(_DexConfigRef ref) async {
  final env = ref
      .watch(SessionProviders.session.select((session) => session.envSelected));

  return ref.watch(_dexConfigRepositoryProvider).getDexConfig(env);
}

abstract class DexConfigProviders {
  static final dexConfig = _dexConfigProvider;
}
