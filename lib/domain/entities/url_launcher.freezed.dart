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
mixin _$UrlLauncher {
  String get urlString => throw _privateConstructorUsedError;
  LaunchMode get mode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UrlLauncherCopyWith<UrlLauncher> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlLauncherCopyWith<$Res> {
  factory $UrlLauncherCopyWith(
          UrlLauncher value, $Res Function(UrlLauncher) then) =
      _$UrlLauncherCopyWithImpl<$Res>;
  $Res call({String urlString, LaunchMode mode});
}

/// @nodoc
class _$UrlLauncherCopyWithImpl<$Res> implements $UrlLauncherCopyWith<$Res> {
  _$UrlLauncherCopyWithImpl(this._value, this._then);

  final UrlLauncher _value;
  // ignore: unused_field
  final $Res Function(UrlLauncher) _then;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
  }) {
    return _then(_value.copyWith(
      urlString: urlString == freezed
          ? _value.urlString
          : urlString // ignore: cast_nullable_to_non_nullable
              as String,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
    ));
  }
}

/// @nodoc
abstract class _$$_UrlLauncherCopyWith<$Res>
    implements $UrlLauncherCopyWith<$Res> {
  factory _$$_UrlLauncherCopyWith(
          _$_UrlLauncher value, $Res Function(_$_UrlLauncher) then) =
      __$$_UrlLauncherCopyWithImpl<$Res>;
  @override
  $Res call({String urlString, LaunchMode mode});
}

/// @nodoc
class __$$_UrlLauncherCopyWithImpl<$Res> extends _$UrlLauncherCopyWithImpl<$Res>
    implements _$$_UrlLauncherCopyWith<$Res> {
  __$$_UrlLauncherCopyWithImpl(
      _$_UrlLauncher _value, $Res Function(_$_UrlLauncher) _then)
      : super(_value, (v) => _then(v as _$_UrlLauncher));

  @override
  _$_UrlLauncher get _value => super._value as _$_UrlLauncher;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
  }) {
    return _then(_$_UrlLauncher(
      urlString: urlString == freezed
          ? _value.urlString
          : urlString // ignore: cast_nullable_to_non_nullable
              as String,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
    ));
  }
}

/// @nodoc

class _$_UrlLauncher extends _UrlLauncher {
  const _$_UrlLauncher({required this.urlString, required this.mode})
      : super._();

  @override
  final String urlString;
  @override
  final LaunchMode mode;

  @override
  String toString() {
    return 'UrlLauncher(urlString: $urlString, mode: $mode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UrlLauncher &&
            const DeepCollectionEquality().equals(other.urlString, urlString) &&
            const DeepCollectionEquality().equals(other.mode, mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(urlString),
      const DeepCollectionEquality().hash(mode));

  @JsonKey(ignore: true)
  @override
  _$$_UrlLauncherCopyWith<_$_UrlLauncher> get copyWith =>
      __$$_UrlLauncherCopyWithImpl<_$_UrlLauncher>(this, _$identity);
}

abstract class _UrlLauncher extends UrlLauncher {
  const factory _UrlLauncher(
      {required final String urlString,
      required final LaunchMode mode}) = _$_UrlLauncher;
  const _UrlLauncher._() : super._();

  @override
  String get urlString;
  @override
  LaunchMode get mode;
  @override
  @JsonKey(ignore: true)
  _$$_UrlLauncherCopyWith<_$_UrlLauncher> get copyWith =>
      throw _privateConstructorUsedError;
}
