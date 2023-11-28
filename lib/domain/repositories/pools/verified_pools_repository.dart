import 'package:aedex/domain/models/verified_pools.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

abstract class VerifiedPoolsRepositoryInterface {
  Future<VerifiedPools> getVerifiedPools();
}
