// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_farm_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetFarmListResponse _$GetFarmListResponseFromJson(Map<String, dynamic> json) {
  return _GetFarmListResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFarmListResponse {
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  int get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  int get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_token')
  String get rewardTokenAddress => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFarmListResponseCopyWith<GetFarmListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFarmListResponseCopyWith<$Res> {
  factory $GetFarmListResponseCopyWith(
          GetFarmListResponse value, $Res Function(GetFarmListResponse) then) =
      _$GetFarmListResponseCopyWithImpl<$Res, GetFarmListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'reward_token') String rewardTokenAddress,
      String address});
}

/// @nodoc
class _$GetFarmListResponseCopyWithImpl<$Res, $Val extends GetFarmListResponse>
    implements $GetFarmListResponseCopyWith<$Res> {
  _$GetFarmListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokenAddress = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? rewardTokenAddress = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      rewardTokenAddress: null == rewardTokenAddress
          ? _value.rewardTokenAddress
          : rewardTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFarmListResponseImplCopyWith<$Res>
    implements $GetFarmListResponseCopyWith<$Res> {
  factory _$$GetFarmListResponseImplCopyWith(_$GetFarmListResponseImpl value,
          $Res Function(_$GetFarmListResponseImpl) then) =
      __$$GetFarmListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'reward_token') String rewardTokenAddress,
      String address});
}

/// @nodoc
class __$$GetFarmListResponseImplCopyWithImpl<$Res>
    extends _$GetFarmListResponseCopyWithImpl<$Res, _$GetFarmListResponseImpl>
    implements _$$GetFarmListResponseImplCopyWith<$Res> {
  __$$GetFarmListResponseImplCopyWithImpl(_$GetFarmListResponseImpl _value,
      $Res Function(_$GetFarmListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokenAddress = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? rewardTokenAddress = null,
    Object? address = null,
  }) {
    return _then(_$GetFarmListResponseImpl(
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      rewardTokenAddress: null == rewardTokenAddress
          ? _value.rewardTokenAddress
          : rewardTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFarmListResponseImpl implements _GetFarmListResponse {
  const _$GetFarmListResponseImpl(
      {@JsonKey(name: 'lp_token_address') required this.lpTokenAddress,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'reward_token') required this.rewardTokenAddress,
      required this.address});

  factory _$GetFarmListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetFarmListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'lp_token_address')
  final String lpTokenAddress;
  @override
  @JsonKey(name: 'start_date')
  final int startDate;
  @override
  @JsonKey(name: 'end_date')
  final int endDate;
  @override
  @JsonKey(name: 'reward_token')
  final String rewardTokenAddress;
  @override
  final String address;

  @override
  String toString() {
    return 'GetFarmListResponse(lpTokenAddress: $lpTokenAddress, startDate: $startDate, endDate: $endDate, rewardTokenAddress: $rewardTokenAddress, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFarmListResponseImpl &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.rewardTokenAddress, rewardTokenAddress) ||
                other.rewardTokenAddress == rewardTokenAddress) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lpTokenAddress, startDate,
      endDate, rewardTokenAddress, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFarmListResponseImplCopyWith<_$GetFarmListResponseImpl> get copyWith =>
      __$$GetFarmListResponseImplCopyWithImpl<_$GetFarmListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFarmListResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFarmListResponse implements GetFarmListResponse {
  const factory _GetFarmListResponse(
      {@JsonKey(name: 'lp_token_address') required final String lpTokenAddress,
      @JsonKey(name: 'start_date') required final int startDate,
      @JsonKey(name: 'end_date') required final int endDate,
      @JsonKey(name: 'reward_token') required final String rewardTokenAddress,
      required final String address}) = _$GetFarmListResponseImpl;

  factory _GetFarmListResponse.fromJson(Map<String, dynamic> json) =
      _$GetFarmListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress;
  @override
  @JsonKey(name: 'start_date')
  int get startDate;
  @override
  @JsonKey(name: 'end_date')
  int get endDate;
  @override
  @JsonKey(name: 'reward_token')
  String get rewardTokenAddress;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$GetFarmListResponseImplCopyWith<_$GetFarmListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
