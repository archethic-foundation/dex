/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/infrastructure/hive/dex_token.hive.dart';
import 'package:hive/hive.dart';

class HiveTokensListDatasource {
  HiveTokensListDatasource._(this._box);

  static const String _tokensListBox = 'tokensListBox';
  final Box<DexTokenHive> _box;

  static const String aeSwapTokensList = 'ae_swap_token_list';

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HiveTokensListDatasource> getInstance() async {
    final box = await Hive.openBox<DexTokenHive>(_tokensListBox);
    return HiveTokensListDatasource._(box);
  }

  Future<void> setTokensList(List<DexTokenHive> v) async {
    await _box.clear();
    for (final token in v) {
      await _box.put(token.address!.toUpperCase(), token);
    }
  }

  Future<void> setToken(DexTokenHive v) async {
    await _box.put(v.address, v);
  }

  DexTokenHive? getToken(String key) {
    return _box.get(key.toUpperCase());
  }

  Future<void> removeToken(DexTokenHive v) async {
    await _box.delete(v.address!.toUpperCase());
  }

  List<DexTokenHive> getTokensList() {
    return _box.values.toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
