// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'url_launcher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UrlLauncherState {
  String? get urlString => throw _privateConstructorUsedError;
  LaunchMode get mode => throw _privateConstructorUsedError;
  UrlLauncherStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UrlLauncherStateCopyWith<UrlLauncherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlLauncherStateCopyWith<$Res> {
  factory $UrlLauncherStateCopyWith(
          UrlLauncherState value, $Res Function(UrlLauncherState) then) =
      _$UrlLauncherStateCopyWithImpl<$Res>;
  $Res call({String? urlString, LaunchMode mode, UrlLauncherStatus status});
}

/// @nodoc
class _$UrlLauncherStateCopyWithImpl<$Res>
    implements $UrlLauncherStateCopyWith<$Res> {
  _$UrlLauncherStateCopyWithImpl(this._value, this._then);

  final UrlLauncherState _value;
  // ignore: unused_field
  final $Res Function(UrlLauncherState) _then;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      urlString: urlString == freezed
          ? _value.urlString
          : urlString // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UrlLauncherStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_UrlLauncherStateCopyWith<$Res>
    implements $UrlLauncherStateCopyWith<$Res> {
  factory _$$_UrlLauncherStateCopyWith(
          _$_UrlLauncherState value, $Res Function(_$_UrlLauncherState) then) =
      __$$_UrlLauncherStateCopyWithImpl<$Res>;
  @override
  $Res call({String? urlString, LaunchMode mode, UrlLauncherStatus status});
}

/// @nodoc
class __$$_UrlLauncherStateCopyWithImpl<$Res>
    extends _$UrlLauncherStateCopyWithImpl<$Res>
    implements _$$_UrlLauncherStateCopyWith<$Res> {
  __$$_UrlLauncherStateCopyWithImpl(
      _$_UrlLauncherState _value, $Res Function(_$_UrlLauncherState) _then)
      : super(_value, (v) => _then(v as _$_UrlLauncherState));

  @override
  _$_UrlLauncherState get _value => super._value as _$_UrlLauncherState;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_UrlLauncherState(
      urlString: urlString == freezed
          ? _value.urlString
          : urlString // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UrlLauncherStatus,
    ));
  }
}

/// @nodoc

class _$_UrlLauncherState implements _UrlLauncherState {
  const _$_UrlLauncherState(
      {this.urlString,
      this.mode = LaunchMode.platformDefault,
      this.status = UrlLauncherStatus.waiting});

  @override
  final String? urlString;
  @override
  @JsonKey()
  final LaunchMode mode;
  @override
  @JsonKey()
  final UrlLauncherStatus status;

  @override
  String toString() {
    return 'UrlLauncherState(urlString: $urlString, mode: $mode, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UrlLauncherState &&
            const DeepCollectionEquality().equals(other.urlString, urlString) &&
            const DeepCollectionEquality().equals(other.mode, mode) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(urlString),
      const DeepCollectionEquality().hash(mode),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_UrlLauncherStateCopyWith<_$_UrlLauncherState> get copyWith =>
      __$$_UrlLauncherStateCopyWithImpl<_$_UrlLauncherState>(this, _$identity);
}

abstract class _UrlLauncherState implements UrlLauncherState {
  const factory _UrlLauncherState(
      {final String? urlString,
      final LaunchMode mode,
      final UrlLauncherStatus status}) = _$_UrlLauncherState;

  @override
  String? get urlString;
  @override
  LaunchMode get mode;
  @override
  UrlLauncherStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_UrlLauncherStateCopyWith<_$_UrlLauncherState> get copyWith =>
      throw _privateConstructorUsedError;
}
