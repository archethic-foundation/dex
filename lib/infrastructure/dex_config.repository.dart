import 'dart:convert';

import 'package:aedex/domain/models/dex_config.dart';
import 'package:aedex/domain/repositories/dex_config.repository.dart';
import 'package:flutter/services.dart';

class DexConfigRepositoryImpl implements DexConfigRepository {
  @override
  Future<DexConfig> getDexConfig(String environment) async {
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/config.json');

    final jsonData = jsonDecode(jsonContent);

    if (environment.isEmpty) {
      return const DexConfig();
    }
    final configList = List<Map<String, dynamic>>.from(jsonData['environment']);
    final configMap = configList.firstWhere(
      (element) => element['name'] == environment,
    );

    return DexConfig.fromJson(configMap);
  }
}
