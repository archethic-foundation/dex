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
mixin _$Session {
// TODO(reddwarf03): MAINNET
//@Default('mainnet') String envSelected,
  String get envSelected => throw _privateConstructorUsedError;
  String get endpoint => throw _privateConstructorUsedError;
  String get nameAccount => throw _privateConstructorUsedError;
  String get oldNameAccount => throw _privateConstructorUsedError;
  String get genesisAddress => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  Subscription<Account>? get accountSub => throw _privateConstructorUsedError;
  StreamSubscription<Account>? get accountStreamSub =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {String envSelected,
      String endpoint,
      String nameAccount,
      String oldNameAccount,
      String genesisAddress,
      String error,
      bool isConnected,
      Subscription<Account>? accountSub,
      StreamSubscription<Account>? accountStreamSub});

  $SubscriptionCopyWith<Account, $Res>? get accountSub;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? envSelected = null,
    Object? endpoint = null,
    Object? nameAccount = null,
    Object? oldNameAccount = null,
    Object? genesisAddress = null,
    Object? error = null,
    Object? isConnected = null,
    Object? accountSub = freezed,
    Object? accountStreamSub = freezed,
  }) {
    return _then(_value.copyWith(
      envSelected: null == envSelected
          ? _value.envSelected
          : envSelected // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      nameAccount: null == nameAccount
          ? _value.nameAccount
          : nameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      oldNameAccount: null == oldNameAccount
          ? _value.oldNameAccount
          : oldNameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      accountSub: freezed == accountSub
          ? _value.accountSub
          : accountSub // ignore: cast_nullable_to_non_nullable
              as Subscription<Account>?,
      accountStreamSub: freezed == accountStreamSub
          ? _value.accountStreamSub
          : accountStreamSub // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<Account>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SubscriptionCopyWith<Account, $Res>? get accountSub {
    if (_value.accountSub == null) {
      return null;
    }

    return $SubscriptionCopyWith<Account, $Res>(_value.accountSub!, (value) {
      return _then(_value.copyWith(accountSub: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String envSelected,
      String endpoint,
      String nameAccount,
      String oldNameAccount,
      String genesisAddress,
      String error,
      bool isConnected,
      Subscription<Account>? accountSub,
      StreamSubscription<Account>? accountStreamSub});

  @override
  $SubscriptionCopyWith<Account, $Res>? get accountSub;
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? envSelected = null,
    Object? endpoint = null,
    Object? nameAccount = null,
    Object? oldNameAccount = null,
    Object? genesisAddress = null,
    Object? error = null,
    Object? isConnected = null,
    Object? accountSub = freezed,
    Object? accountStreamSub = freezed,
  }) {
    return _then(_$SessionImpl(
      envSelected: null == envSelected
          ? _value.envSelected
          : envSelected // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      nameAccount: null == nameAccount
          ? _value.nameAccount
          : nameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      oldNameAccount: null == oldNameAccount
          ? _value.oldNameAccount
          : oldNameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      accountSub: freezed == accountSub
          ? _value.accountSub
          : accountSub // ignore: cast_nullable_to_non_nullable
              as Subscription<Account>?,
      accountStreamSub: freezed == accountStreamSub
          ? _value.accountStreamSub
          : accountStreamSub // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<Account>?,
    ));
  }
}

/// @nodoc

class _$SessionImpl extends _Session {
  const _$SessionImpl(
      {this.envSelected = 'testnet',
      this.endpoint = '',
      this.nameAccount = '',
      this.oldNameAccount = '',
      this.genesisAddress = '',
      this.error = '',
      this.isConnected = false,
      this.accountSub,
      this.accountStreamSub})
      : super._();

// TODO(reddwarf03): MAINNET
//@Default('mainnet') String envSelected,
  @override
  @JsonKey()
  final String envSelected;
  @override
  @JsonKey()
  final String endpoint;
  @override
  @JsonKey()
  final String nameAccount;
  @override
  @JsonKey()
  final String oldNameAccount;
  @override
  @JsonKey()
  final String genesisAddress;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  final Subscription<Account>? accountSub;
  @override
  final StreamSubscription<Account>? accountStreamSub;

  @override
  String toString() {
    return 'Session(envSelected: $envSelected, endpoint: $endpoint, nameAccount: $nameAccount, oldNameAccount: $oldNameAccount, genesisAddress: $genesisAddress, error: $error, isConnected: $isConnected, accountSub: $accountSub, accountStreamSub: $accountStreamSub)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.envSelected, envSelected) ||
                other.envSelected == envSelected) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.nameAccount, nameAccount) ||
                other.nameAccount == nameAccount) &&
            (identical(other.oldNameAccount, oldNameAccount) ||
                other.oldNameAccount == oldNameAccount) &&
            (identical(other.genesisAddress, genesisAddress) ||
                other.genesisAddress == genesisAddress) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.accountSub, accountSub) ||
                other.accountSub == accountSub) &&
            (identical(other.accountStreamSub, accountStreamSub) ||
                other.accountStreamSub == accountStreamSub));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      envSelected,
      endpoint,
      nameAccount,
      oldNameAccount,
      genesisAddress,
      error,
      isConnected,
      accountSub,
      accountStreamSub);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);
}

abstract class _Session extends Session {
  const factory _Session(
      {final String envSelected,
      final String endpoint,
      final String nameAccount,
      final String oldNameAccount,
      final String genesisAddress,
      final String error,
      final bool isConnected,
      final Subscription<Account>? accountSub,
      final StreamSubscription<Account>? accountStreamSub}) = _$SessionImpl;
  const _Session._() : super._();

  @override // TODO(reddwarf03): MAINNET
//@Default('mainnet') String envSelected,
  String get envSelected;
  @override
  String get endpoint;
  @override
  String get nameAccount;
  @override
  String get oldNameAccount;
  @override
  String get genesisAddress;
  @override
  String get error;
  @override
  bool get isConnected;
  @override
  Subscription<Account>? get accountSub;
  @override
  StreamSubscription<Account>? get accountStreamSub;
  @override
  @JsonKey(ignore: true)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
