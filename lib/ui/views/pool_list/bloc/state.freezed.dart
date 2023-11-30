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
mixin _$PoolListFormState {
  bool get onlyVerifiedPools => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PoolListFormStateCopyWith<PoolListFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolListFormStateCopyWith<$Res> {
  factory $PoolListFormStateCopyWith(
          PoolListFormState value, $Res Function(PoolListFormState) then) =
      _$PoolListFormStateCopyWithImpl<$Res, PoolListFormState>;
  @useResult
  $Res call({bool onlyVerifiedPools});
}

/// @nodoc
class _$PoolListFormStateCopyWithImpl<$Res, $Val extends PoolListFormState>
    implements $PoolListFormStateCopyWith<$Res> {
  _$PoolListFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyVerifiedPools = null,
  }) {
    return _then(_value.copyWith(
      onlyVerifiedPools: null == onlyVerifiedPools
          ? _value.onlyVerifiedPools
          : onlyVerifiedPools // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoolListFormStateImplCopyWith<$Res>
    implements $PoolListFormStateCopyWith<$Res> {
  factory _$$PoolListFormStateImplCopyWith(_$PoolListFormStateImpl value,
          $Res Function(_$PoolListFormStateImpl) then) =
      __$$PoolListFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool onlyVerifiedPools});
}

/// @nodoc
class __$$PoolListFormStateImplCopyWithImpl<$Res>
    extends _$PoolListFormStateCopyWithImpl<$Res, _$PoolListFormStateImpl>
    implements _$$PoolListFormStateImplCopyWith<$Res> {
  __$$PoolListFormStateImplCopyWithImpl(_$PoolListFormStateImpl _value,
      $Res Function(_$PoolListFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyVerifiedPools = null,
  }) {
    return _then(_$PoolListFormStateImpl(
      onlyVerifiedPools: null == onlyVerifiedPools
          ? _value.onlyVerifiedPools
          : onlyVerifiedPools // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PoolListFormStateImpl extends _PoolListFormState {
  const _$PoolListFormStateImpl({this.onlyVerifiedPools = true}) : super._();

  @override
  @JsonKey()
  final bool onlyVerifiedPools;

  @override
  String toString() {
    return 'PoolListFormState(onlyVerifiedPools: $onlyVerifiedPools)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolListFormStateImpl &&
            (identical(other.onlyVerifiedPools, onlyVerifiedPools) ||
                other.onlyVerifiedPools == onlyVerifiedPools));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onlyVerifiedPools);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      __$$PoolListFormStateImplCopyWithImpl<_$PoolListFormStateImpl>(
          this, _$identity);
}

abstract class _PoolListFormState extends PoolListFormState {
  const factory _PoolListFormState({final bool onlyVerifiedPools}) =
      _$PoolListFormStateImpl;
  const _PoolListFormState._() : super._();

  @override
  bool get onlyVerifiedPools;
  @override
  @JsonKey(ignore: true)
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}