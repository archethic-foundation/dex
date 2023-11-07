// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PoolAddFormState {
  String get token1Address => throw _privateConstructorUsedError;
  String get token2Address => throw _privateConstructorUsedError;
  dynamic get processInProgress => throw _privateConstructorUsedError;
  bool? get token1AddressOk => throw _privateConstructorUsedError;
  bool? get token2AddressOk => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PoolAddFormStateCopyWith<PoolAddFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolAddFormStateCopyWith<$Res> {
  factory $PoolAddFormStateCopyWith(
          PoolAddFormState value, $Res Function(PoolAddFormState) then) =
      _$PoolAddFormStateCopyWithImpl<$Res, PoolAddFormState>;
  @useResult
  $Res call(
      {String token1Address,
      String token2Address,
      dynamic processInProgress,
      bool? token1AddressOk,
      bool? token2AddressOk,
      double fee,
      Failure? failure});

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$PoolAddFormStateCopyWithImpl<$Res, $Val extends PoolAddFormState>
    implements $PoolAddFormStateCopyWith<$Res> {
  _$PoolAddFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1Address = null,
    Object? token2Address = null,
    Object? processInProgress = freezed,
    Object? token1AddressOk = freezed,
    Object? token2AddressOk = freezed,
    Object? fee = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      token1Address: null == token1Address
          ? _value.token1Address
          : token1Address // ignore: cast_nullable_to_non_nullable
              as String,
      token2Address: null == token2Address
          ? _value.token2Address
          : token2Address // ignore: cast_nullable_to_non_nullable
              as String,
      processInProgress: freezed == processInProgress
          ? _value.processInProgress
          : processInProgress // ignore: cast_nullable_to_non_nullable
              as dynamic,
      token1AddressOk: freezed == token1AddressOk
          ? _value.token1AddressOk
          : token1AddressOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      token2AddressOk: freezed == token2AddressOk
          ? _value.token2AddressOk
          : token2AddressOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PoolAddFormStateImplCopyWith<$Res>
    implements $PoolAddFormStateCopyWith<$Res> {
  factory _$$PoolAddFormStateImplCopyWith(_$PoolAddFormStateImpl value,
          $Res Function(_$PoolAddFormStateImpl) then) =
      __$$PoolAddFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token1Address,
      String token2Address,
      dynamic processInProgress,
      bool? token1AddressOk,
      bool? token2AddressOk,
      double fee,
      Failure? failure});

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$PoolAddFormStateImplCopyWithImpl<$Res>
    extends _$PoolAddFormStateCopyWithImpl<$Res, _$PoolAddFormStateImpl>
    implements _$$PoolAddFormStateImplCopyWith<$Res> {
  __$$PoolAddFormStateImplCopyWithImpl(_$PoolAddFormStateImpl _value,
      $Res Function(_$PoolAddFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1Address = null,
    Object? token2Address = null,
    Object? processInProgress = freezed,
    Object? token1AddressOk = freezed,
    Object? token2AddressOk = freezed,
    Object? fee = null,
    Object? failure = freezed,
  }) {
    return _then(_$PoolAddFormStateImpl(
      token1Address: null == token1Address
          ? _value.token1Address
          : token1Address // ignore: cast_nullable_to_non_nullable
              as String,
      token2Address: null == token2Address
          ? _value.token2Address
          : token2Address // ignore: cast_nullable_to_non_nullable
              as String,
      processInProgress: freezed == processInProgress
          ? _value.processInProgress!
          : processInProgress,
      token1AddressOk: freezed == token1AddressOk
          ? _value.token1AddressOk
          : token1AddressOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      token2AddressOk: freezed == token2AddressOk
          ? _value.token2AddressOk
          : token2AddressOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$PoolAddFormStateImpl extends _PoolAddFormState {
  const _$PoolAddFormStateImpl(
      {this.token1Address = '',
      this.token2Address = '',
      this.processInProgress = false,
      this.token1AddressOk,
      this.token2AddressOk,
      this.fee = 0,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final String token1Address;
  @override
  @JsonKey()
  final String token2Address;
  @override
  @JsonKey()
  final dynamic processInProgress;
  @override
  final bool? token1AddressOk;
  @override
  final bool? token2AddressOk;
  @override
  @JsonKey()
  final double fee;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'PoolAddFormState(token1Address: $token1Address, token2Address: $token2Address, processInProgress: $processInProgress, token1AddressOk: $token1AddressOk, token2AddressOk: $token2AddressOk, fee: $fee, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolAddFormStateImpl &&
            (identical(other.token1Address, token1Address) ||
                other.token1Address == token1Address) &&
            (identical(other.token2Address, token2Address) ||
                other.token2Address == token2Address) &&
            const DeepCollectionEquality()
                .equals(other.processInProgress, processInProgress) &&
            (identical(other.token1AddressOk, token1AddressOk) ||
                other.token1AddressOk == token1AddressOk) &&
            (identical(other.token2AddressOk, token2AddressOk) ||
                other.token2AddressOk == token2AddressOk) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      token1Address,
      token2Address,
      const DeepCollectionEquality().hash(processInProgress),
      token1AddressOk,
      token2AddressOk,
      fee,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolAddFormStateImplCopyWith<_$PoolAddFormStateImpl> get copyWith =>
      __$$PoolAddFormStateImplCopyWithImpl<_$PoolAddFormStateImpl>(
          this, _$identity);
}

abstract class _PoolAddFormState extends PoolAddFormState {
  const factory _PoolAddFormState(
      {final String token1Address,
      final String token2Address,
      final dynamic processInProgress,
      final bool? token1AddressOk,
      final bool? token2AddressOk,
      final double fee,
      final Failure? failure}) = _$PoolAddFormStateImpl;
  const _PoolAddFormState._() : super._();

  @override
  String get token1Address;
  @override
  String get token2Address;
  @override
  dynamic get processInProgress;
  @override
  bool? get token1AddressOk;
  @override
  bool? get token2AddressOk;
  @override
  double get fee;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$PoolAddFormStateImplCopyWith<_$PoolAddFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
