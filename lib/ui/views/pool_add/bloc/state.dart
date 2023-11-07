import 'package:aedex/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolAddFormState with _$PoolAddFormState {
  const factory PoolAddFormState({
    @Default('') String token1Address,
    @Default('') String token2Address,
    @Default(false) processInProgress,
    bool? token1AddressOk,
    bool? token2AddressOk,
    @Default(0) double fee,
    Failure? failure,
  }) = _PoolAddFormState;
  const PoolAddFormState._();

  bool get isControlsOk =>
      failure == null &&
      token1Address.isNotEmpty &&
      token2Address.isNotEmpty &&
      token1AddressOk == true &&
      token2AddressOk == true;
}
