// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RepoCount {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoCountCopyWith<RepoCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoCountCopyWith<$Res> {
  factory $RepoCountCopyWith(RepoCount value, $Res Function(RepoCount) then) =
      _$RepoCountCopyWithImpl<$Res, RepoCount>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$RepoCountCopyWithImpl<$Res, $Val extends RepoCount>
    implements $RepoCountCopyWith<$Res> {
  _$RepoCountCopyWithImpl(this._value, this._then);

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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepoCountImplCopyWith<$Res>
    implements $RepoCountCopyWith<$Res> {
  factory _$$RepoCountImplCopyWith(
          _$RepoCountImpl value, $Res Function(_$RepoCountImpl) then) =
      __$$RepoCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$RepoCountImplCopyWithImpl<$Res>
    extends _$RepoCountCopyWithImpl<$Res, _$RepoCountImpl>
    implements _$$RepoCountImplCopyWith<$Res> {
  __$$RepoCountImplCopyWithImpl(
      _$RepoCountImpl _value, $Res Function(_$RepoCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$RepoCountImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RepoCountImpl extends _RepoCount {
  const _$RepoCountImpl([this.value = 0]) : super._();

  @override
  @JsonKey()
  final int value;

  @override
  String toString() {
    return 'RepoCount(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoCountImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoCountImplCopyWith<_$RepoCountImpl> get copyWith =>
      __$$RepoCountImplCopyWithImpl<_$RepoCountImpl>(this, _$identity);
}

abstract class _RepoCount extends RepoCount {
  const factory _RepoCount([final int value]) = _$RepoCountImpl;
  const _RepoCount._() : super._();

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$RepoCountImplCopyWith<_$RepoCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
