// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'url_launch_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UrlLaunchData {
  String get urlString => throw _privateConstructorUsedError;
  UrlLauncheMode get mode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UrlLaunchDataCopyWith<UrlLaunchData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlLaunchDataCopyWith<$Res> {
  factory $UrlLaunchDataCopyWith(
          UrlLaunchData value, $Res Function(UrlLaunchData) then) =
      _$UrlLaunchDataCopyWithImpl<$Res>;
  $Res call({String urlString, UrlLauncheMode mode});
}

/// @nodoc
class _$UrlLaunchDataCopyWithImpl<$Res>
    implements $UrlLaunchDataCopyWith<$Res> {
  _$UrlLaunchDataCopyWithImpl(this._value, this._then);

  final UrlLaunchData _value;
  // ignore: unused_field
  final $Res Function(UrlLaunchData) _then;

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
              as UrlLauncheMode,
    ));
  }
}

/// @nodoc
abstract class _$$_UrlLaunchDataCopyWith<$Res>
    implements $UrlLaunchDataCopyWith<$Res> {
  factory _$$_UrlLaunchDataCopyWith(
          _$_UrlLaunchData value, $Res Function(_$_UrlLaunchData) then) =
      __$$_UrlLaunchDataCopyWithImpl<$Res>;
  @override
  $Res call({String urlString, UrlLauncheMode mode});
}

/// @nodoc
class __$$_UrlLaunchDataCopyWithImpl<$Res>
    extends _$UrlLaunchDataCopyWithImpl<$Res>
    implements _$$_UrlLaunchDataCopyWith<$Res> {
  __$$_UrlLaunchDataCopyWithImpl(
      _$_UrlLaunchData _value, $Res Function(_$_UrlLaunchData) _then)
      : super(_value, (v) => _then(v as _$_UrlLaunchData));

  @override
  _$_UrlLaunchData get _value => super._value as _$_UrlLaunchData;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
  }) {
    return _then(_$_UrlLaunchData(
      urlString: urlString == freezed
          ? _value.urlString
          : urlString // ignore: cast_nullable_to_non_nullable
              as String,
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as UrlLauncheMode,
    ));
  }
}

/// @nodoc

class _$_UrlLaunchData extends _UrlLaunchData {
  const _$_UrlLaunchData({required this.urlString, required this.mode})
      : super._();

  @override
  final String urlString;
  @override
  final UrlLauncheMode mode;

  @override
  String toString() {
    return 'UrlLaunchData(urlString: $urlString, mode: $mode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UrlLaunchData &&
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
  _$$_UrlLaunchDataCopyWith<_$_UrlLaunchData> get copyWith =>
      __$$_UrlLaunchDataCopyWithImpl<_$_UrlLaunchData>(this, _$identity);
}

abstract class _UrlLaunchData extends UrlLaunchData {
  const factory _UrlLaunchData(
      {required final String urlString,
      required final UrlLauncheMode mode}) = _$_UrlLaunchData;
  const _UrlLaunchData._() : super._();

  @override
  String get urlString;
  @override
  UrlLauncheMode get mode;
  @override
  @JsonKey(ignore: true)
  _$$_UrlLaunchDataCopyWith<_$_UrlLaunchData> get copyWith =>
      throw _privateConstructorUsedError;
}
