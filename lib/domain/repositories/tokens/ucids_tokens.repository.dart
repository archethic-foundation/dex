/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/ucids_tokens.dart';

abstract class UcidsTokensRepositoryInterface {
  Future<UcidsTokens> getUcidsTokens();

  Future<Map<String, int>> getUcidsTokensFromNetwork();
}
