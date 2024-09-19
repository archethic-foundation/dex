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

@Riverpod(keepAlive: true)
Future<DexConfig> _dexConfig(_DexConfigRef ref) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(_dexConfigRepositoryProvider).getDexConfig(environment);
}

abstract class DexConfigProviders {
  static final dexConfigRepository = _dexConfigRepositoryProvider;
  static final dexConfig = _dexConfigProvider;
}
