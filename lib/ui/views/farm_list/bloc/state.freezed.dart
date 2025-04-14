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
mixin _$FarmListFormState {
  AsyncValue<List<DexFarm>> get farmsToDisplay =>
      throw _privateConstructorUsedError;
  String? get cancelToken => throw _privateConstructorUsedError;

  /// Create a copy of FarmListFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FarmListFormStateCopyWith<FarmListFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmListFormStateCopyWith<$Res> {
  factory $FarmListFormStateCopyWith(
          FarmListFormState value, $Res Function(FarmListFormState) then) =
      _$FarmListFormStateCopyWithImpl<$Res, FarmListFormState>;
  @useResult
  $Res call({AsyncValue<List<DexFarm>> farmsToDisplay, String? cancelToken});
}

/// @nodoc
class _$FarmListFormStateCopyWithImpl<$Res, $Val extends FarmListFormState>
    implements $FarmListFormStateCopyWith<$Res> {
  _$FarmListFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FarmListFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmsToDisplay = null,
    Object? cancelToken = freezed,
  }) {
    return _then(_value.copyWith(
      farmsToDisplay: null == farmsToDisplay
          ? _value.farmsToDisplay
          : farmsToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DexFarm>>,
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FarmListFormStateImplCopyWith<$Res>
    implements $FarmListFormStateCopyWith<$Res> {
  factory _$$FarmListFormStateImplCopyWith(_$FarmListFormStateImpl value,
          $Res Function(_$FarmListFormStateImpl) then) =
      __$$FarmListFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<DexFarm>> farmsToDisplay, String? cancelToken});
}

/// @nodoc
class __$$FarmListFormStateImplCopyWithImpl<$Res>
    extends _$FarmListFormStateCopyWithImpl<$Res, _$FarmListFormStateImpl>
    implements _$$FarmListFormStateImplCopyWith<$Res> {
  __$$FarmListFormStateImplCopyWithImpl(_$FarmListFormStateImpl _value,
      $Res Function(_$FarmListFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FarmListFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmsToDisplay = null,
    Object? cancelToken = freezed,
  }) {
    return _then(_$FarmListFormStateImpl(
      farmsToDisplay: null == farmsToDisplay
          ? _value.farmsToDisplay
          : farmsToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DexFarm>>,
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FarmListFormStateImpl extends _FarmListFormState {
  const _$FarmListFormStateImpl(
      {required this.farmsToDisplay, this.cancelToken})
      : super._();

  @override
  final AsyncValue<List<DexFarm>> farmsToDisplay;
  @override
  final String? cancelToken;

  @override
  String toString() {
    return 'FarmListFormState(farmsToDisplay: $farmsToDisplay, cancelToken: $cancelToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmListFormStateImpl &&
            (identical(other.farmsToDisplay, farmsToDisplay) ||
                other.farmsToDisplay == farmsToDisplay) &&
            (identical(other.cancelToken, cancelToken) ||
                other.cancelToken == cancelToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, farmsToDisplay, cancelToken);

  /// Create a copy of FarmListFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmListFormStateImplCopyWith<_$FarmListFormStateImpl> get copyWith =>
      __$$FarmListFormStateImplCopyWithImpl<_$FarmListFormStateImpl>(
          this, _$identity);
}

abstract class _FarmListFormState extends FarmListFormState {
  const factory _FarmListFormState(
      {required final AsyncValue<List<DexFarm>> farmsToDisplay,
      final String? cancelToken}) = _$FarmListFormStateImpl;
  const _FarmListFormState._() : super._();

  @override
  AsyncValue<List<DexFarm>> get farmsToDisplay;
  @override
  String? get cancelToken;

  /// Create a copy of FarmListFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FarmListFormStateImplCopyWith<_$FarmListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
