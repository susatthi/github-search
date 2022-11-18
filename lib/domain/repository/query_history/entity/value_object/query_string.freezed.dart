// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'query_string.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QueryString {
  String get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QueryStringCopyWith<QueryString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryStringCopyWith<$Res> {
  factory $QueryStringCopyWith(
          QueryString value, $Res Function(QueryString) then) =
      _$QueryStringCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$QueryStringCopyWithImpl<$Res> implements $QueryStringCopyWith<$Res> {
  _$QueryStringCopyWithImpl(this._value, this._then);

  final QueryString _value;
  // ignore: unused_field
  final $Res Function(QueryString) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_QueryStringCopyWith<$Res>
    implements $QueryStringCopyWith<$Res> {
  factory _$$_QueryStringCopyWith(
          _$_QueryString value, $Res Function(_$_QueryString) then) =
      __$$_QueryStringCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class __$$_QueryStringCopyWithImpl<$Res> extends _$QueryStringCopyWithImpl<$Res>
    implements _$$_QueryStringCopyWith<$Res> {
  __$$_QueryStringCopyWithImpl(
      _$_QueryString _value, $Res Function(_$_QueryString) _then)
      : super(_value, (v) => _then(v as _$_QueryString));

  @override
  _$_QueryString get _value => super._value as _$_QueryString;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$_QueryString(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_QueryString extends _QueryString {
  _$_QueryString([this.value = '']) : super._();

  @override
  @JsonKey()
  final String value;

  @override
  String toString() {
    return 'QueryString(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QueryString &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_QueryStringCopyWith<_$_QueryString> get copyWith =>
      __$$_QueryStringCopyWithImpl<_$_QueryString>(this, _$identity);
}

abstract class _QueryString extends QueryString {
  factory _QueryString([final String value]) = _$_QueryString;
  _QueryString._() : super._();

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_QueryStringCopyWith<_$_QueryString> get copyWith =>
      throw _privateConstructorUsedError;
}
