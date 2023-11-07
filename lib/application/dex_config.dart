/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/repositories/dex_config.repository.dart';
import 'package:aedex/infrastructure/dex_config.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_config.g.dart';

@riverpod
DexConfigRepository _dexConfigRepository(
  _DexConfigRepositoryRef ref,
) =>
    DexConfigRepositoryImpl();

abstract class DexConfigProviders {
  static final dexConfigRepository = _dexConfigRepositoryProvider;
}
