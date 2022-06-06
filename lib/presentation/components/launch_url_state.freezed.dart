// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'launch_url_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LaunchUrlState {
  String? get urlString => throw _privateConstructorUsedError;
  LaunchMode get mode => throw _privateConstructorUsedError;
  LaunchUrlStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LaunchUrlStateCopyWith<LaunchUrlState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaunchUrlStateCopyWith<$Res> {
  factory $LaunchUrlStateCopyWith(
          LaunchUrlState value, $Res Function(LaunchUrlState) then) =
      _$LaunchUrlStateCopyWithImpl<$Res>;
  $Res call({String? urlString, LaunchMode mode, LaunchUrlStatus status});
}

/// @nodoc
class _$LaunchUrlStateCopyWithImpl<$Res>
    implements $LaunchUrlStateCopyWith<$Res> {
  _$LaunchUrlStateCopyWithImpl(this._value, this._then);

  final LaunchUrlState _value;
  // ignore: unused_field
  final $Res Function(LaunchUrlState) _then;

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
              as LaunchUrlStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_LaunchUrlStateCopyWith<$Res>
    implements $LaunchUrlStateCopyWith<$Res> {
  factory _$$_LaunchUrlStateCopyWith(
          _$_LaunchUrlState value, $Res Function(_$_LaunchUrlState) then) =
      __$$_LaunchUrlStateCopyWithImpl<$Res>;
  @override
  $Res call({String? urlString, LaunchMode mode, LaunchUrlStatus status});
}

/// @nodoc
class __$$_LaunchUrlStateCopyWithImpl<$Res>
    extends _$LaunchUrlStateCopyWithImpl<$Res>
    implements _$$_LaunchUrlStateCopyWith<$Res> {
  __$$_LaunchUrlStateCopyWithImpl(
      _$_LaunchUrlState _value, $Res Function(_$_LaunchUrlState) _then)
      : super(_value, (v) => _then(v as _$_LaunchUrlState));

  @override
  _$_LaunchUrlState get _value => super._value as _$_LaunchUrlState;

  @override
  $Res call({
    Object? urlString = freezed,
    Object? mode = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_LaunchUrlState(
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
              as LaunchUrlStatus,
    ));
  }
}

/// @nodoc

class _$_LaunchUrlState implements _LaunchUrlState {
  const _$_LaunchUrlState(
      {this.urlString,
      this.mode = LaunchMode.platformDefault,
      this.status = LaunchUrlStatus.wating});

  @override
  final String? urlString;
  @override
  @JsonKey()
  final LaunchMode mode;
  @override
  @JsonKey()
  final LaunchUrlStatus status;

  @override
  String toString() {
    return 'LaunchUrlState(urlString: $urlString, mode: $mode, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LaunchUrlState &&
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
  _$$_LaunchUrlStateCopyWith<_$_LaunchUrlState> get copyWith =>
      __$$_LaunchUrlStateCopyWithImpl<_$_LaunchUrlState>(this, _$identity);
}

abstract class _LaunchUrlState implements LaunchUrlState {
  const factory _LaunchUrlState(
      {final String? urlString,
      final LaunchMode mode,
      final LaunchUrlStatus status}) = _$_LaunchUrlState;

  @override
  String? get urlString => throw _privateConstructorUsedError;
  @override
  LaunchMode get mode => throw _privateConstructorUsedError;
  @override
  LaunchUrlStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LaunchUrlStateCopyWith<_$_LaunchUrlState> get copyWith =>
      throw _privateConstructorUsedError;
}
