/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_item.freezed.dart';

@freezed
class PoolItemState with _$PoolItemState {
  const factory PoolItemState({
    required String poolAddress,
    DexPool? pool,
    @Default(0.0) double volume24h,
    @Default(0.0) double fee24h,
    @Default(0.0) double volumeAllTime,
    @Default(0.0) double feeAllTime,
  }) = _PoolItemState;
  const PoolItemState._();
}
