// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repo_language.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RepoLanguage {
  String? get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoLanguageCopyWith<RepoLanguage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoLanguageCopyWith<$Res> {
  factory $RepoLanguageCopyWith(
          RepoLanguage value, $Res Function(RepoLanguage) then) =
      _$RepoLanguageCopyWithImpl<$Res>;
  $Res call({String? value});
}

/// @nodoc
class _$RepoLanguageCopyWithImpl<$Res> implements $RepoLanguageCopyWith<$Res> {
  _$RepoLanguageCopyWithImpl(this._value, this._then);

  final RepoLanguage _value;
  // ignore: unused_field
  final $Res Function(RepoLanguage) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_RepoLanguageCopyWith<$Res>
    implements $RepoLanguageCopyWith<$Res> {
  factory _$$_RepoLanguageCopyWith(
          _$_RepoLanguage value, $Res Function(_$_RepoLanguage) then) =
      __$$_RepoLanguageCopyWithImpl<$Res>;
  @override
  $Res call({String? value});
}

/// @nodoc
class __$$_RepoLanguageCopyWithImpl<$Res>
    extends _$RepoLanguageCopyWithImpl<$Res>
    implements _$$_RepoLanguageCopyWith<$Res> {
  __$$_RepoLanguageCopyWithImpl(
      _$_RepoLanguage _value, $Res Function(_$_RepoLanguage) _then)
      : super(_value, (v) => _then(v as _$_RepoLanguage));

  @override
  _$_RepoLanguage get _value => super._value as _$_RepoLanguage;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$_RepoLanguage(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RepoLanguage implements _RepoLanguage {
  const _$_RepoLanguage([this.value]);

  @override
  final String? value;

  @override
  String toString() {
    return 'RepoLanguage(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepoLanguage &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_RepoLanguageCopyWith<_$_RepoLanguage> get copyWith =>
      __$$_RepoLanguageCopyWithImpl<_$_RepoLanguage>(this, _$identity);
}

abstract class _RepoLanguage implements RepoLanguage {
  const factory _RepoLanguage([final String? value]) = _$_RepoLanguage;

  @override
  String? get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepoLanguageCopyWith<_$_RepoLanguage> get copyWith =>
      throw _privateConstructorUsedError;
}
