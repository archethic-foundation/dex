/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmListFormState with _$FarmListFormState {
  const factory FarmListFormState({
    required AsyncValue<List<DexFarm>> farmsToDisplay,
    String? cancelToken,
  }) = _FarmListFormState;
  const FarmListFormState._();
}
