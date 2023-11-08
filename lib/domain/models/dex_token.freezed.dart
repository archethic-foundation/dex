// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DexToken {
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexTokenCopyWith<DexToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexTokenCopyWith<$Res> {
  factory $DexTokenCopyWith(DexToken value, $Res Function(DexToken) then) =
      _$DexTokenCopyWithImpl<$Res, DexToken>;
  @useResult
  $Res call({String name, String? address, String symbol, double balance});
}

/// @nodoc
class _$DexTokenCopyWithImpl<$Res, $Val extends DexToken>
    implements $DexTokenCopyWith<$Res> {
  _$DexTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = freezed,
    Object? symbol = null,
    Object? balance = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexTokenImplCopyWith<$Res>
    implements $DexTokenCopyWith<$Res> {
  factory _$$DexTokenImplCopyWith(
          _$DexTokenImpl value, $Res Function(_$DexTokenImpl) then) =
      __$$DexTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? address, String symbol, double balance});
}

/// @nodoc
class __$$DexTokenImplCopyWithImpl<$Res>
    extends _$DexTokenCopyWithImpl<$Res, _$DexTokenImpl>
    implements _$$DexTokenImplCopyWith<$Res> {
  __$$DexTokenImplCopyWithImpl(
      _$DexTokenImpl _value, $Res Function(_$DexTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = freezed,
    Object? symbol = null,
    Object? balance = null,
  }) {
    return _then(_$DexTokenImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexTokenImpl implements _DexToken {
  const _$DexTokenImpl(
      {this.name = '', this.address, this.symbol = '', this.balance = 0.0});

  @override
  @JsonKey()
  final String name;
  @override
  final String? address;
  @override
  @JsonKey()
  final String symbol;
  @override
  @JsonKey()
  final double balance;

  @override
  String toString() {
    return 'DexToken(name: $name, address: $address, symbol: $symbol, balance: $balance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexTokenImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, address, symbol, balance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexTokenImplCopyWith<_$DexTokenImpl> get copyWith =>
      __$$DexTokenImplCopyWithImpl<_$DexTokenImpl>(this, _$identity);
}

abstract class _DexToken implements DexToken {
  const factory _DexToken(
      {final String name,
      final String? address,
      final String symbol,
      final double balance}) = _$DexTokenImpl;

  @override
  String get name;
  @override
  String? get address;
  @override
  String get symbol;
  @override
  double get balance;
  @override
  @JsonKey(ignore: true)
  _$$DexTokenImplCopyWith<_$DexTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}