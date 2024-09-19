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
  PoolsListTab get selectedTab => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

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
  $Res call({PoolsListTab selectedTab, String searchText});
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
    Object? selectedTab = null,
    Object? searchText = null,
  }) {
    return _then(_value.copyWith(
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as PoolsListTab,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({PoolsListTab selectedTab, String searchText});
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
    Object? selectedTab = null,
    Object? searchText = null,
  }) {
    return _then(_$PoolListFormStateImpl(
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as PoolsListTab,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PoolListFormStateImpl extends _PoolListFormState {
  const _$PoolListFormStateImpl(
      {this.selectedTab = PoolsListTab.verified, this.searchText = ''})
      : super._();

  @override
  @JsonKey()
  final PoolsListTab selectedTab;
  @override
  @JsonKey()
  final String searchText;

  @override
  String toString() {
    return 'PoolListFormState(selectedTab: $selectedTab, searchText: $searchText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolListFormStateImpl &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedTab, searchText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      __$$PoolListFormStateImplCopyWithImpl<_$PoolListFormStateImpl>(
          this, _$identity);
}

abstract class _PoolListFormState extends PoolListFormState {
  const factory _PoolListFormState(
      {final PoolsListTab selectedTab,
      final String searchText}) = _$PoolListFormStateImpl;
  const _PoolListFormState._() : super._();

  @override
  PoolsListTab get selectedTab;
  @override
  String get searchText;
  @override
  @JsonKey(ignore: true)
  _$$PoolListFormStateImplCopyWith<_$PoolListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
