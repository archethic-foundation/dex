// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_notification_widget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskNotificationPopup {
  Key? get key => throw _privateConstructorUsedError;
  Widget get icon => throw _privateConstructorUsedError;
  Widget? get title => throw _privateConstructorUsedError;
  Widget get description => throw _privateConstructorUsedError;
  Widget? get action => throw _privateConstructorUsedError;
  VoidCallback? get onActionPressed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskNotificationPopupCopyWith<TaskNotificationPopup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskNotificationPopupCopyWith<$Res> {
  factory $TaskNotificationPopupCopyWith(TaskNotificationPopup value,
          $Res Function(TaskNotificationPopup) then) =
      _$TaskNotificationPopupCopyWithImpl<$Res, TaskNotificationPopup>;
  @useResult
  $Res call(
      {Key? key,
      Widget icon,
      Widget? title,
      Widget description,
      Widget? action,
      VoidCallback? onActionPressed});
}

/// @nodoc
class _$TaskNotificationPopupCopyWithImpl<$Res,
        $Val extends TaskNotificationPopup>
    implements $TaskNotificationPopupCopyWith<$Res> {
  _$TaskNotificationPopupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? icon = null,
    Object? title = freezed,
    Object? description = null,
    Object? action = freezed,
    Object? onActionPressed = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Widget,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Widget?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Widget,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as Widget?,
      onActionPressed: freezed == onActionPressed
          ? _value.onActionPressed
          : onActionPressed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskNotificationPopupImplCopyWith<$Res>
    implements $TaskNotificationPopupCopyWith<$Res> {
  factory _$$TaskNotificationPopupImplCopyWith(
          _$TaskNotificationPopupImpl value,
          $Res Function(_$TaskNotificationPopupImpl) then) =
      __$$TaskNotificationPopupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Key? key,
      Widget icon,
      Widget? title,
      Widget description,
      Widget? action,
      VoidCallback? onActionPressed});
}

/// @nodoc
class __$$TaskNotificationPopupImplCopyWithImpl<$Res>
    extends _$TaskNotificationPopupCopyWithImpl<$Res,
        _$TaskNotificationPopupImpl>
    implements _$$TaskNotificationPopupImplCopyWith<$Res> {
  __$$TaskNotificationPopupImplCopyWithImpl(_$TaskNotificationPopupImpl _value,
      $Res Function(_$TaskNotificationPopupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? icon = null,
    Object? title = freezed,
    Object? description = null,
    Object? action = freezed,
    Object? onActionPressed = freezed,
  }) {
    return _then(_$TaskNotificationPopupImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as Widget,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Widget?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Widget,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as Widget?,
      onActionPressed: freezed == onActionPressed
          ? _value.onActionPressed
          : onActionPressed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc

class _$TaskNotificationPopupImpl extends _TaskNotificationPopup {
  const _$TaskNotificationPopupImpl(
      {this.key,
      required this.icon,
      this.title,
      required this.description,
      this.action,
      this.onActionPressed})
      : super._();

  @override
  final Key? key;
  @override
  final Widget icon;
  @override
  final Widget? title;
  @override
  final Widget description;
  @override
  final Widget? action;
  @override
  final VoidCallback? onActionPressed;

  @override
  String toString() {
    return 'TaskNotificationPopup(key: $key, icon: $icon, title: $title, description: $description, action: $action, onActionPressed: $onActionPressed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskNotificationPopupImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.onActionPressed, onActionPressed) ||
                other.onActionPressed == onActionPressed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, key, icon, title, description, action, onActionPressed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskNotificationPopupImplCopyWith<_$TaskNotificationPopupImpl>
      get copyWith => __$$TaskNotificationPopupImplCopyWithImpl<
          _$TaskNotificationPopupImpl>(this, _$identity);
}

abstract class _TaskNotificationPopup extends TaskNotificationPopup {
  const factory _TaskNotificationPopup(
      {final Key? key,
      required final Widget icon,
      final Widget? title,
      required final Widget description,
      final Widget? action,
      final VoidCallback? onActionPressed}) = _$TaskNotificationPopupImpl;
  const _TaskNotificationPopup._() : super._();

  @override
  Key? get key;
  @override
  Widget get icon;
  @override
  Widget? get title;
  @override
  Widget get description;
  @override
  Widget? get action;
  @override
  VoidCallback? get onActionPressed;
  @override
  @JsonKey(ignore: true)
  _$$TaskNotificationPopupImplCopyWith<_$TaskNotificationPopupImpl>
      get copyWith => throw _privateConstructorUsedError;
}
