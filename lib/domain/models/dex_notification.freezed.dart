// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DexNotification {
  DexActionType get actionType => throw _privateConstructorUsedError;
  String? get txAddress => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexNotificationCopyWith<DexNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexNotificationCopyWith<$Res> {
  factory $DexNotificationCopyWith(
          DexNotification value, $Res Function(DexNotification) then) =
      _$DexNotificationCopyWithImpl<$Res, DexNotification>;
  @useResult
  $Res call({DexActionType actionType, String? txAddress});
}

/// @nodoc
class _$DexNotificationCopyWithImpl<$Res, $Val extends DexNotification>
    implements $DexNotificationCopyWith<$Res> {
  _$DexNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
  }) {
    return _then(_value.copyWith(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexNotificationSwapImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationSwapImplCopyWith(_$DexNotificationSwapImpl value,
          $Res Function(_$DexNotificationSwapImpl) then) =
      __$$DexNotificationSwapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountSwapped,
      DexToken? tokenSwapped});

  $DexTokenCopyWith<$Res>? get tokenSwapped;
}

/// @nodoc
class __$$DexNotificationSwapImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res, _$DexNotificationSwapImpl>
    implements _$$DexNotificationSwapImplCopyWith<$Res> {
  __$$DexNotificationSwapImplCopyWithImpl(_$DexNotificationSwapImpl _value,
      $Res Function(_$DexNotificationSwapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountSwapped = freezed,
    Object? tokenSwapped = freezed,
  }) {
    return _then(_$DexNotificationSwapImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountSwapped: freezed == amountSwapped
          ? _value.amountSwapped
          : amountSwapped // ignore: cast_nullable_to_non_nullable
              as double?,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenSwapped {
    if (_value.tokenSwapped == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenSwapped!, (value) {
      return _then(_value.copyWith(tokenSwapped: value));
    });
  }
}

/// @nodoc

class _$DexNotificationSwapImpl extends _DexNotificationSwap {
  const _$DexNotificationSwapImpl(
      {this.actionType = DexActionType.swap,
      this.txAddress,
      this.amountSwapped,
      this.tokenSwapped})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountSwapped;
  @override
  final DexToken? tokenSwapped;

  @override
  String toString() {
    return 'DexNotification.swap(actionType: $actionType, txAddress: $txAddress, amountSwapped: $amountSwapped, tokenSwapped: $tokenSwapped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationSwapImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountSwapped, amountSwapped) ||
                other.amountSwapped == amountSwapped) &&
            (identical(other.tokenSwapped, tokenSwapped) ||
                other.tokenSwapped == tokenSwapped));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, actionType, txAddress, amountSwapped, tokenSwapped);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationSwapImplCopyWith<_$DexNotificationSwapImpl> get copyWith =>
      __$$DexNotificationSwapImplCopyWithImpl<_$DexNotificationSwapImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
  }) {
    return swap(actionType, txAddress, amountSwapped, tokenSwapped);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
  }) {
    return swap?.call(actionType, txAddress, amountSwapped, tokenSwapped);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(actionType, txAddress, amountSwapped, tokenSwapped);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
  }) {
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
  }) {
    return swap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationSwap extends DexNotification {
  const factory _DexNotificationSwap(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountSwapped,
      final DexToken? tokenSwapped}) = _$DexNotificationSwapImpl;
  const _DexNotificationSwap._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountSwapped;
  DexToken? get tokenSwapped;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationSwapImplCopyWith<_$DexNotificationSwapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationAddLiquidityImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationAddLiquidityImplCopyWith(
          _$DexNotificationAddLiquidityImpl value,
          $Res Function(_$DexNotificationAddLiquidityImpl) then) =
      __$$DexNotificationAddLiquidityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      DexToken? lpToken});

  $DexTokenCopyWith<$Res>? get lpToken;
}

/// @nodoc
class __$$DexNotificationAddLiquidityImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationAddLiquidityImpl>
    implements _$$DexNotificationAddLiquidityImplCopyWith<$Res> {
  __$$DexNotificationAddLiquidityImplCopyWithImpl(
      _$DexNotificationAddLiquidityImpl _value,
      $Res Function(_$DexNotificationAddLiquidityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? lpToken = freezed,
  }) {
    return _then(_$DexNotificationAddLiquidityImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationAddLiquidityImpl extends _DexNotificationAddLiquidity {
  const _$DexNotificationAddLiquidityImpl(
      {this.actionType = DexActionType.addLiquidity,
      this.txAddress,
      this.amount,
      this.lpToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final DexToken? lpToken;

  @override
  String toString() {
    return 'DexNotification.addLiquidity(actionType: $actionType, txAddress: $txAddress, amount: $amount, lpToken: $lpToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationAddLiquidityImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, actionType, txAddress, amount, lpToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationAddLiquidityImplCopyWith<_$DexNotificationAddLiquidityImpl>
      get copyWith => __$$DexNotificationAddLiquidityImplCopyWithImpl<
          _$DexNotificationAddLiquidityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
  }) {
    return addLiquidity(actionType, txAddress, amount, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
  }) {
    return addLiquidity?.call(actionType, txAddress, amount, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    required TResult orElse(),
  }) {
    if (addLiquidity != null) {
      return addLiquidity(actionType, txAddress, amount, lpToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
  }) {
    return addLiquidity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
  }) {
    return addLiquidity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    required TResult orElse(),
  }) {
    if (addLiquidity != null) {
      return addLiquidity(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationAddLiquidity extends DexNotification {
  const factory _DexNotificationAddLiquidity(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final DexToken? lpToken}) = _$DexNotificationAddLiquidityImpl;
  const _DexNotificationAddLiquidity._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  DexToken? get lpToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationAddLiquidityImplCopyWith<_$DexNotificationAddLiquidityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationRemoveLiquidityImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationRemoveLiquidityImplCopyWith(
          _$DexNotificationRemoveLiquidityImpl value,
          $Res Function(_$DexNotificationRemoveLiquidityImpl) then) =
      __$$DexNotificationRemoveLiquidityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountToken1,
      double? amountToken2,
      double? amountLPToken,
      DexToken? token1,
      DexToken? token2,
      DexToken? lpToken});

  $DexTokenCopyWith<$Res>? get token1;
  $DexTokenCopyWith<$Res>? get token2;
  $DexTokenCopyWith<$Res>? get lpToken;
}

/// @nodoc
class __$$DexNotificationRemoveLiquidityImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationRemoveLiquidityImpl>
    implements _$$DexNotificationRemoveLiquidityImplCopyWith<$Res> {
  __$$DexNotificationRemoveLiquidityImplCopyWithImpl(
      _$DexNotificationRemoveLiquidityImpl _value,
      $Res Function(_$DexNotificationRemoveLiquidityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountToken1 = freezed,
    Object? amountToken2 = freezed,
    Object? amountLPToken = freezed,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? lpToken = freezed,
  }) {
    return _then(_$DexNotificationRemoveLiquidityImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountToken1: freezed == amountToken1
          ? _value.amountToken1
          : amountToken1 // ignore: cast_nullable_to_non_nullable
              as double?,
      amountToken2: freezed == amountToken2
          ? _value.amountToken2
          : amountToken2 // ignore: cast_nullable_to_non_nullable
              as double?,
      amountLPToken: freezed == amountLPToken
          ? _value.amountLPToken
          : amountLPToken // ignore: cast_nullable_to_non_nullable
              as double?,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token1 {
    if (_value.token1 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token1!, (value) {
      return _then(_value.copyWith(token1: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token2 {
    if (_value.token2 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token2!, (value) {
      return _then(_value.copyWith(token2: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationRemoveLiquidityImpl
    extends _DexNotificationRemoveLiquidity {
  const _$DexNotificationRemoveLiquidityImpl(
      {this.actionType = DexActionType.removeLiquidity,
      this.txAddress,
      this.amountToken1,
      this.amountToken2,
      this.amountLPToken,
      this.token1,
      this.token2,
      this.lpToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountToken1;
  @override
  final double? amountToken2;
  @override
  final double? amountLPToken;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  final DexToken? lpToken;

  @override
  String toString() {
    return 'DexNotification.removeLiquidity(actionType: $actionType, txAddress: $txAddress, amountToken1: $amountToken1, amountToken2: $amountToken2, amountLPToken: $amountLPToken, token1: $token1, token2: $token2, lpToken: $lpToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationRemoveLiquidityImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountToken1, amountToken1) ||
                other.amountToken1 == amountToken1) &&
            (identical(other.amountToken2, amountToken2) ||
                other.amountToken2 == amountToken2) &&
            (identical(other.amountLPToken, amountLPToken) ||
                other.amountLPToken == amountLPToken) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, actionType, txAddress,
      amountToken1, amountToken2, amountLPToken, token1, token2, lpToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationRemoveLiquidityImplCopyWith<
          _$DexNotificationRemoveLiquidityImpl>
      get copyWith => __$$DexNotificationRemoveLiquidityImplCopyWithImpl<
          _$DexNotificationRemoveLiquidityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
  }) {
    return removeLiquidity(actionType, txAddress, amountToken1, amountToken2,
        amountLPToken, token1, token2, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
  }) {
    return removeLiquidity?.call(actionType, txAddress, amountToken1,
        amountToken2, amountLPToken, token1, token2, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    required TResult orElse(),
  }) {
    if (removeLiquidity != null) {
      return removeLiquidity(actionType, txAddress, amountToken1, amountToken2,
          amountLPToken, token1, token2, lpToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
  }) {
    return removeLiquidity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
  }) {
    return removeLiquidity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    required TResult orElse(),
  }) {
    if (removeLiquidity != null) {
      return removeLiquidity(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationRemoveLiquidity extends DexNotification {
  const factory _DexNotificationRemoveLiquidity(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountToken1,
      final double? amountToken2,
      final double? amountLPToken,
      final DexToken? token1,
      final DexToken? token2,
      final DexToken? lpToken}) = _$DexNotificationRemoveLiquidityImpl;
  const _DexNotificationRemoveLiquidity._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountToken1;
  double? get amountToken2;
  double? get amountLPToken;
  DexToken? get token1;
  DexToken? get token2;
  DexToken? get lpToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationRemoveLiquidityImplCopyWith<
          _$DexNotificationRemoveLiquidityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
