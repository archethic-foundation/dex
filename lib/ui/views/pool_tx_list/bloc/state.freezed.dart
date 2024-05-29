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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PoolTxListFormState {
  List<DexPoolTx>? get result => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PoolTxListFormStateCopyWith<PoolTxListFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolTxListFormStateCopyWith<$Res> {
  factory $PoolTxListFormStateCopyWith(
          PoolTxListFormState value, $Res Function(PoolTxListFormState) then) =
      _$PoolTxListFormStateCopyWithImpl<$Res, PoolTxListFormState>;
  @useResult
  $Res call({List<DexPoolTx>? result});
}

/// @nodoc
class _$PoolTxListFormStateCopyWithImpl<$Res, $Val extends PoolTxListFormState>
    implements $PoolTxListFormStateCopyWith<$Res> {
  _$PoolTxListFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<DexPoolTx>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoolTxListFormStateImplCopyWith<$Res>
    implements $PoolTxListFormStateCopyWith<$Res> {
  factory _$$PoolTxListFormStateImplCopyWith(_$PoolTxListFormStateImpl value,
          $Res Function(_$PoolTxListFormStateImpl) then) =
      __$$PoolTxListFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DexPoolTx>? result});
}

/// @nodoc
class __$$PoolTxListFormStateImplCopyWithImpl<$Res>
    extends _$PoolTxListFormStateCopyWithImpl<$Res, _$PoolTxListFormStateImpl>
    implements _$$PoolTxListFormStateImplCopyWith<$Res> {
  __$$PoolTxListFormStateImplCopyWithImpl(_$PoolTxListFormStateImpl _value,
      $Res Function(_$PoolTxListFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_$PoolTxListFormStateImpl(
      result: freezed == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<DexPoolTx>?,
    ));
  }
}

/// @nodoc

class _$PoolTxListFormStateImpl extends _PoolTxListFormState {
  const _$PoolTxListFormStateImpl({final List<DexPoolTx>? result})
      : _result = result,
        super._();

  final List<DexPoolTx>? _result;
  @override
  List<DexPoolTx>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PoolTxListFormState(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolTxListFormStateImpl &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolTxListFormStateImplCopyWith<_$PoolTxListFormStateImpl> get copyWith =>
      __$$PoolTxListFormStateImplCopyWithImpl<_$PoolTxListFormStateImpl>(
          this, _$identity);
}

abstract class _PoolTxListFormState extends PoolTxListFormState {
  const factory _PoolTxListFormState({final List<DexPoolTx>? result}) =
      _$PoolTxListFormStateImpl;
  const _PoolTxListFormState._() : super._();

  @override
  List<DexPoolTx>? get result;
  @override
  @JsonKey(ignore: true)
  _$$PoolTxListFormStateImplCopyWith<_$PoolTxListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
