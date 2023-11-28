/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aedex/domain/models/verified_pools.dart';
import 'package:aedex/domain/repositories/pools/verified_pools_repository.dart';
import 'package:flutter/services.dart';

class VerifiedPoolsList implements VerifiedPoolsRepositoryInterface {
  @override
  Future<VerifiedPools> getVerifiedPools() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/pools/verified_pools.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return VerifiedPools.fromJson(jsonData);
  }
}
