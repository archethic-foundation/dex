// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DexPair {
  DexToken get token1 => throw _privateConstructorUsedError;
  DexToken get token2 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexPairCopyWith<DexPair> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPairCopyWith<$Res> {
  factory $DexPairCopyWith(DexPair value, $Res Function(DexPair) then) =
      _$DexPairCopyWithImpl<$Res, DexPair>;
  @useResult
  $Res call({DexToken token1, DexToken token2});

  $DexTokenCopyWith<$Res> get token1;
  $DexTokenCopyWith<$Res> get token2;
}

/// @nodoc
class _$DexPairCopyWithImpl<$Res, $Val extends DexPair>
    implements $DexPairCopyWith<$Res> {
  _$DexPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
  }) {
    return _then(_value.copyWith(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get token1 {
    return $DexTokenCopyWith<$Res>(_value.token1, (value) {
      return _then(_value.copyWith(token1: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get token2 {
    return $DexTokenCopyWith<$Res>(_value.token2, (value) {
      return _then(_value.copyWith(token2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DexPairCopyWith<$Res> implements $DexPairCopyWith<$Res> {
  factory _$$_DexPairCopyWith(
          _$_DexPair value, $Res Function(_$_DexPair) then) =
      __$$_DexPairCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DexToken token1, DexToken token2});

  @override
  $DexTokenCopyWith<$Res> get token1;
  @override
  $DexTokenCopyWith<$Res> get token2;
}

/// @nodoc
class __$$_DexPairCopyWithImpl<$Res>
    extends _$DexPairCopyWithImpl<$Res, _$_DexPair>
    implements _$$_DexPairCopyWith<$Res> {
  __$$_DexPairCopyWithImpl(_$_DexPair _value, $Res Function(_$_DexPair) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
  }) {
    return _then(_$_DexPair(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken,
    ));
  }
}

/// @nodoc

class _$_DexPair implements _DexPair {
  const _$_DexPair({required this.token1, required this.token2});

  @override
  final DexToken token1;
  @override
  final DexToken token2;

  @override
  String toString() {
    return 'DexPair(token1: $token1, token2: $token2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DexPair &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token1, token2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DexPairCopyWith<_$_DexPair> get copyWith =>
      __$$_DexPairCopyWithImpl<_$_DexPair>(this, _$identity);
}

abstract class _DexPair implements DexPair {
  const factory _DexPair(
      {required final DexToken token1,
      required final DexToken token2}) = _$_DexPair;

  @override
  DexToken get token1;
  @override
  DexToken get token2;
  @override
  @JsonKey(ignore: true)
  _$$_DexPairCopyWith<_$_DexPair> get copyWith =>
      throw _privateConstructorUsedError;
}
