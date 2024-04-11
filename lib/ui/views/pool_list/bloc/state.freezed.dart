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
mixin _$PoolListFormState {
  PoolsListTab get tabIndexSelected => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;
  AsyncValue<List<DexPool>> get poolsToDisplay =>
      throw _privateConstructorUsedError;
  String? get cancelToken => throw _privateConstructorUsedError;

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
  $Res call(
      {PoolsListTab tabIndexSelected,
      String searchText,
      AsyncValue<List<DexPool>> poolsToDisplay,
      String? cancelToken});
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
    Object? tabIndexSelected = null,
    Object? searchText = null,
    Object? poolsToDisplay = null,
    Object? cancelToken = freezed,
  }) {
    return _then(_value.copyWith(
      tabIndexSelected: null == tabIndexSelected
          ? _value.tabIndexSelected
          : tabIndexSelected // ignore: cast_nullable_to_non_nullable
              as PoolsListTab,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      poolsToDisplay: null == poolsToDisplay
          ? _value.poolsToDisplay
          : poolsToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DexPool>>,
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call(
      {PoolsListTab tabIndexSelected,
      String searchText,
      AsyncValue<List<DexPool>> poolsToDisplay,
      String? cancelToken});
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
    Object? tabIndexSelected = null,
    Object? searchText = null,
    Object? poolsToDisplay = null,
    Object? cancelToken = freezed,
  }) {
    return _then(_$PoolListFormStateImpl(
      tabIndexSelected: null == tabIndexSelected
          ? _value.tabIndexSelected
          : tabIndexSelected // ignore: cast_nullable_to_non_nullable
              as PoolsListTab,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      poolsToDisplay: null == poolsToDisplay
          ? _value.poolsToDisplay
          : poolsToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DexPool>>,
      cancelToken: freezed == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PoolListFormStateImpl extends _PoolListFormState {
  const _$PoolListFormStateImpl(
      {this.tabIndexSelected = PoolsListTab.verified,
      this.searchText = '',
      required this.poolsToDisplay,
      this.cancelToken})
      : super._();

  @override
  @JsonKey()
  final PoolsListTab tabIndexSelected;
  @override
  @JsonKey()
  final String searchText;
  @override
  final AsyncValue<List<DexPool>> poolsToDisplay;
  @override
  final String? cancelToken;

  @override
  String toString() {
    return 'PoolListFormState(tabIndexSelected: $tabIndexSelected, searchText: $searchText, poolsToDisplay: $poolsToDisplay, cancelToken: $cancelToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolListFormStateImpl &&
            (identical(other.tabIndexSelected, tabIndexSelected) ||
                other.tabIndexSelected == tabIndexSelected) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            (identical(other.poolsToDisplay, poolsToDisplay) ||
                other.poolsToDisplay == poolsToDisplay) &&
            (identical(other.cancelToken, cancelToken) ||
                other.cancelToken == cancelToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tabIndexSelected, searchText, poolsToDisplay, cancelToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      __$$PoolListFormStateImplCopyWithImpl<_$PoolListFormStateImpl>(
          this, _$identity);
}

abstract class _PoolListFormState extends PoolListFormState {
  const factory _PoolListFormState(
      {final PoolsListTab tabIndexSelected,
      final String searchText,
      required final AsyncValue<List<DexPool>> poolsToDisplay,
      final String? cancelToken}) = _$PoolListFormStateImpl;
  const _PoolListFormState._() : super._();

  @override
  PoolsListTab get tabIndexSelected;
  @override
  String get searchText;
  @override
  AsyncValue<List<DexPool>> get poolsToDisplay;
  @override
  String? get cancelToken;
  @override
  @JsonKey(ignore: true)
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
