/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/infrastructure/hive/dex_pair.hive.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/dex_token.hive.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveTypeIds {
  static const cacheManager = 1;
  static const dexPair = 2;
  static const dexPool = 3;
  static const dexToken = 4;
}

class DBHelper {
  static Future<void> setupDatabase() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final suppDir = await getApplicationSupportDirectory();
      Hive.init(suppDir.path);
    }

    Hive
      ..registerAdapter(DexPairHiveAdapter())
      ..registerAdapter(DexPoolHiveAdapter())
      ..registerAdapter(DexTokenHiveAdapter());
  }
}
