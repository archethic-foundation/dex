import 'package:aedex/domain/models/verified_tokens.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

abstract class VerifiedTokensRepositoryInterface {
  Future<VerifiedTokens> getVerifiedTokens();
}
