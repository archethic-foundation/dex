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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TokenSelectionFormState {
  String get searchText => throw _privateConstructorUsedError;
  List<DexToken>? get result => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenSelectionFormStateCopyWith<TokenSelectionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSelectionFormStateCopyWith<$Res> {
  factory $TokenSelectionFormStateCopyWith(TokenSelectionFormState value,
          $Res Function(TokenSelectionFormState) then) =
      _$TokenSelectionFormStateCopyWithImpl<$Res, TokenSelectionFormState>;
  @useResult
  $Res call({String searchText, List<DexToken>? result});
}

/// @nodoc
class _$TokenSelectionFormStateCopyWithImpl<$Res,
        $Val extends TokenSelectionFormState>
    implements $TokenSelectionFormStateCopyWith<$Res> {
  _$TokenSelectionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = null,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<DexToken>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenSelectionFormStateImplCopyWith<$Res>
    implements $TokenSelectionFormStateCopyWith<$Res> {
  factory _$$TokenSelectionFormStateImplCopyWith(
          _$TokenSelectionFormStateImpl value,
          $Res Function(_$TokenSelectionFormStateImpl) then) =
      __$$TokenSelectionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String searchText, List<DexToken>? result});
}

/// @nodoc
class __$$TokenSelectionFormStateImplCopyWithImpl<$Res>
    extends _$TokenSelectionFormStateCopyWithImpl<$Res,
        _$TokenSelectionFormStateImpl>
    implements _$$TokenSelectionFormStateImplCopyWith<$Res> {
  __$$TokenSelectionFormStateImplCopyWithImpl(
      _$TokenSelectionFormStateImpl _value,
      $Res Function(_$TokenSelectionFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = null,
    Object? result = freezed,
  }) {
    return _then(_$TokenSelectionFormStateImpl(
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
      result: freezed == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<DexToken>?,
    ));
  }
}

/// @nodoc

class _$TokenSelectionFormStateImpl extends _TokenSelectionFormState {
  const _$TokenSelectionFormStateImpl(
      {this.searchText = '', final List<DexToken>? result})
      : _result = result,
        super._();

  @override
  @JsonKey()
  final String searchText;
  final List<DexToken>? _result;
  @override
  List<DexToken>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TokenSelectionFormState(searchText: $searchText, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenSelectionFormStateImpl &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, searchText, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenSelectionFormStateImplCopyWith<_$TokenSelectionFormStateImpl>
      get copyWith => __$$TokenSelectionFormStateImplCopyWithImpl<
          _$TokenSelectionFormStateImpl>(this, _$identity);
}

abstract class _TokenSelectionFormState extends TokenSelectionFormState {
  const factory _TokenSelectionFormState(
      {final String searchText,
      final List<DexToken>? result}) = _$TokenSelectionFormStateImpl;
  const _TokenSelectionFormState._() : super._();

  @override
  String get searchText;
  @override
  List<DexToken>? get result;
  @override
  @JsonKey(ignore: true)
  _$$TokenSelectionFormStateImplCopyWith<_$TokenSelectionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
