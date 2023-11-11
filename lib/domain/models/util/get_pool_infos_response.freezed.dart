// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_pool_infos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetPoolInfosResponse _$GetPoolInfosResponseFromJson(Map<String, dynamic> json) {
  return _GetPoolInfosResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPoolInfosResponse {
  Token get token1 => throw _privateConstructorUsedError;
  Token get token2 =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'lp_token')
  LPToken get lpToken => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPoolInfosResponseCopyWith<GetPoolInfosResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPoolInfosResponseCopyWith<$Res> {
  factory $GetPoolInfosResponseCopyWith(GetPoolInfosResponse value,
          $Res Function(GetPoolInfosResponse) then) =
      _$GetPoolInfosResponseCopyWithImpl<$Res, GetPoolInfosResponse>;
  @useResult
  $Res call(
      {Token token1,
      Token token2,
      @JsonKey(name: 'lp_token') LPToken lpToken,
      double fee});

  $TokenCopyWith<$Res> get token1;
  $TokenCopyWith<$Res> get token2;
  $LPTokenCopyWith<$Res> get lpToken;
}

/// @nodoc
class _$GetPoolInfosResponseCopyWithImpl<$Res,
        $Val extends GetPoolInfosResponse>
    implements $GetPoolInfosResponseCopyWith<$Res> {
  _$GetPoolInfosResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
    Object? lpToken = null,
    Object? fee = null,
  }) {
    return _then(_value.copyWith(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as Token,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as Token,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as LPToken,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res> get token1 {
    return $TokenCopyWith<$Res>(_value.token1, (value) {
      return _then(_value.copyWith(token1: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res> get token2 {
    return $TokenCopyWith<$Res>(_value.token2, (value) {
      return _then(_value.copyWith(token2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LPTokenCopyWith<$Res> get lpToken {
    return $LPTokenCopyWith<$Res>(_value.lpToken, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPoolInfosResponseImplCopyWith<$Res>
    implements $GetPoolInfosResponseCopyWith<$Res> {
  factory _$$GetPoolInfosResponseImplCopyWith(_$GetPoolInfosResponseImpl value,
          $Res Function(_$GetPoolInfosResponseImpl) then) =
      __$$GetPoolInfosResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Token token1,
      Token token2,
      @JsonKey(name: 'lp_token') LPToken lpToken,
      double fee});

  @override
  $TokenCopyWith<$Res> get token1;
  @override
  $TokenCopyWith<$Res> get token2;
  @override
  $LPTokenCopyWith<$Res> get lpToken;
}

/// @nodoc
class __$$GetPoolInfosResponseImplCopyWithImpl<$Res>
    extends _$GetPoolInfosResponseCopyWithImpl<$Res, _$GetPoolInfosResponseImpl>
    implements _$$GetPoolInfosResponseImplCopyWith<$Res> {
  __$$GetPoolInfosResponseImplCopyWithImpl(_$GetPoolInfosResponseImpl _value,
      $Res Function(_$GetPoolInfosResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
    Object? lpToken = null,
    Object? fee = null,
  }) {
    return _then(_$GetPoolInfosResponseImpl(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as Token,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as Token,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as LPToken,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPoolInfosResponseImpl implements _GetPoolInfosResponse {
  const _$GetPoolInfosResponseImpl(
      {required this.token1,
      required this.token2,
      @JsonKey(name: 'lp_token') required this.lpToken,
      required this.fee});

  factory _$GetPoolInfosResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPoolInfosResponseImplFromJson(json);

  @override
  final Token token1;
  @override
  final Token token2;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'lp_token')
  final LPToken lpToken;
  @override
  final double fee;

  @override
  String toString() {
    return 'GetPoolInfosResponse(token1: $token1, token2: $token2, lpToken: $lpToken, fee: $fee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPoolInfosResponseImpl &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token1, token2, lpToken, fee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPoolInfosResponseImplCopyWith<_$GetPoolInfosResponseImpl>
      get copyWith =>
          __$$GetPoolInfosResponseImplCopyWithImpl<_$GetPoolInfosResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPoolInfosResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPoolInfosResponse implements GetPoolInfosResponse {
  const factory _GetPoolInfosResponse(
      {required final Token token1,
      required final Token token2,
      @JsonKey(name: 'lp_token') required final LPToken lpToken,
      required final double fee}) = _$GetPoolInfosResponseImpl;

  factory _GetPoolInfosResponse.fromJson(Map<String, dynamic> json) =
      _$GetPoolInfosResponseImpl.fromJson;

  @override
  Token get token1;
  @override
  Token get token2;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'lp_token')
  LPToken get lpToken;
  @override
  double get fee;
  @override
  @JsonKey(ignore: true)
  _$$GetPoolInfosResponseImplCopyWith<_$GetPoolInfosResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
mixin _$Token {
  String get address => throw _privateConstructorUsedError;
  double get reserve => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call({String address, double reserve});
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? reserve = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      reserve: null == reserve
          ? _value.reserve
          : reserve // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenImplCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$TokenImplCopyWith(
          _$TokenImpl value, $Res Function(_$TokenImpl) then) =
      __$$TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, double reserve});
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? reserve = null,
  }) {
    return _then(_$TokenImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      reserve: null == reserve
          ? _value.reserve
          : reserve // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenImpl implements _Token {
  const _$TokenImpl({required this.address, required this.reserve});

  factory _$TokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenImplFromJson(json);

  @override
  final String address;
  @override
  final double reserve;

  @override
  String toString() {
    return 'Token(address: $address, reserve: $reserve)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.reserve, reserve) || other.reserve == reserve));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, reserve);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      __$$TokenImplCopyWithImpl<_$TokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenImplToJson(
      this,
    );
  }
}

abstract class _Token implements Token {
  const factory _Token(
      {required final String address,
      required final double reserve}) = _$TokenImpl;

  factory _Token.fromJson(Map<String, dynamic> json) = _$TokenImpl.fromJson;

  @override
  String get address;
  @override
  double get reserve;
  @override
  @JsonKey(ignore: true)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LPToken _$LPTokenFromJson(Map<String, dynamic> json) {
  return _LPToken.fromJson(json);
}

/// @nodoc
mixin _$LPToken {
  String get address => throw _privateConstructorUsedError;
  double get supply => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LPTokenCopyWith<LPToken> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LPTokenCopyWith<$Res> {
  factory $LPTokenCopyWith(LPToken value, $Res Function(LPToken) then) =
      _$LPTokenCopyWithImpl<$Res, LPToken>;
  @useResult
  $Res call({String address, double supply});
}

/// @nodoc
class _$LPTokenCopyWithImpl<$Res, $Val extends LPToken>
    implements $LPTokenCopyWith<$Res> {
  _$LPTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? supply = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LPTokenImplCopyWith<$Res> implements $LPTokenCopyWith<$Res> {
  factory _$$LPTokenImplCopyWith(
          _$LPTokenImpl value, $Res Function(_$LPTokenImpl) then) =
      __$$LPTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, double supply});
}

/// @nodoc
class __$$LPTokenImplCopyWithImpl<$Res>
    extends _$LPTokenCopyWithImpl<$Res, _$LPTokenImpl>
    implements _$$LPTokenImplCopyWith<$Res> {
  __$$LPTokenImplCopyWithImpl(
      _$LPTokenImpl _value, $Res Function(_$LPTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? supply = null,
  }) {
    return _then(_$LPTokenImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LPTokenImpl implements _LPToken {
  const _$LPTokenImpl({required this.address, required this.supply});

  factory _$LPTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$LPTokenImplFromJson(json);

  @override
  final String address;
  @override
  final double supply;

  @override
  String toString() {
    return 'LPToken(address: $address, supply: $supply)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LPTokenImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.supply, supply) || other.supply == supply));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, supply);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LPTokenImplCopyWith<_$LPTokenImpl> get copyWith =>
      __$$LPTokenImplCopyWithImpl<_$LPTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LPTokenImplToJson(
      this,
    );
  }
}

abstract class _LPToken implements LPToken {
  const factory _LPToken(
      {required final String address,
      required final double supply}) = _$LPTokenImpl;

  factory _LPToken.fromJson(Map<String, dynamic> json) = _$LPTokenImpl.fromJson;

  @override
  String get address;
  @override
  double get supply;
  @override
  @JsonKey(ignore: true)
  _$$LPTokenImplCopyWith<_$LPTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
