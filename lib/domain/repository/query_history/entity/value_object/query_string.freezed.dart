// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$QueryStringCopyWithImpl<$Res, QueryString>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$QueryStringCopyWithImpl<$Res, $Val extends QueryString>
    implements $QueryStringCopyWith<$Res> {
  _$QueryStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueryStringImplCopyWith<$Res>
    implements $QueryStringCopyWith<$Res> {
  factory _$$QueryStringImplCopyWith(
          _$QueryStringImpl value, $Res Function(_$QueryStringImpl) then) =
      __$$QueryStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$QueryStringImplCopyWithImpl<$Res>
    extends _$QueryStringCopyWithImpl<$Res, _$QueryStringImpl>
    implements _$$QueryStringImplCopyWith<$Res> {
  __$$QueryStringImplCopyWithImpl(
      _$QueryStringImpl _value, $Res Function(_$QueryStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$QueryStringImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueryStringImpl extends _QueryString {
  _$QueryStringImpl([this.value = '']) : super._();

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
            other is _$QueryStringImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryStringImplCopyWith<_$QueryStringImpl> get copyWith =>
      __$$QueryStringImplCopyWithImpl<_$QueryStringImpl>(this, _$identity);
}

abstract class _QueryString extends QueryString {
  factory _QueryString([final String value]) = _$QueryStringImpl;
  _QueryString._() : super._();

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$QueryStringImplCopyWith<_$QueryStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
