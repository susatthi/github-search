// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'query_history_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QueryHistoryInput {
  /// 検索文字列
  String get queryString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QueryHistoryInputCopyWith<QueryHistoryInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryHistoryInputCopyWith<$Res> {
  factory $QueryHistoryInputCopyWith(
          QueryHistoryInput value, $Res Function(QueryHistoryInput) then) =
      _$QueryHistoryInputCopyWithImpl<$Res>;
  $Res call({String queryString});
}

/// @nodoc
class _$QueryHistoryInputCopyWithImpl<$Res>
    implements $QueryHistoryInputCopyWith<$Res> {
  _$QueryHistoryInputCopyWithImpl(this._value, this._then);

  final QueryHistoryInput _value;
  // ignore: unused_field
  final $Res Function(QueryHistoryInput) _then;

  @override
  $Res call({
    Object? queryString = freezed,
  }) {
    return _then(_value.copyWith(
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_QueryHistoryInputCopyWith<$Res>
    implements $QueryHistoryInputCopyWith<$Res> {
  factory _$$_QueryHistoryInputCopyWith(_$_QueryHistoryInput value,
          $Res Function(_$_QueryHistoryInput) then) =
      __$$_QueryHistoryInputCopyWithImpl<$Res>;
  @override
  $Res call({String queryString});
}

/// @nodoc
class __$$_QueryHistoryInputCopyWithImpl<$Res>
    extends _$QueryHistoryInputCopyWithImpl<$Res>
    implements _$$_QueryHistoryInputCopyWith<$Res> {
  __$$_QueryHistoryInputCopyWithImpl(
      _$_QueryHistoryInput _value, $Res Function(_$_QueryHistoryInput) _then)
      : super(_value, (v) => _then(v as _$_QueryHistoryInput));

  @override
  _$_QueryHistoryInput get _value => super._value as _$_QueryHistoryInput;

  @override
  $Res call({
    Object? queryString = freezed,
  }) {
    return _then(_$_QueryHistoryInput(
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_QueryHistoryInput extends _QueryHistoryInput {
  _$_QueryHistoryInput({required this.queryString}) : super._();

  /// 検索文字列
  @override
  final String queryString;

  @override
  String toString() {
    return 'QueryHistoryInput(queryString: $queryString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QueryHistoryInput &&
            const DeepCollectionEquality()
                .equals(other.queryString, queryString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(queryString));

  @JsonKey(ignore: true)
  @override
  _$$_QueryHistoryInputCopyWith<_$_QueryHistoryInput> get copyWith =>
      __$$_QueryHistoryInputCopyWithImpl<_$_QueryHistoryInput>(
          this, _$identity);
}

abstract class _QueryHistoryInput extends QueryHistoryInput {
  factory _QueryHistoryInput({required final String queryString}) =
      _$_QueryHistoryInput;
  _QueryHistoryInput._() : super._();

  @override

  /// 検索文字列
  String get queryString;
  @override
  @JsonKey(ignore: true)
  _$$_QueryHistoryInputCopyWith<_$_QueryHistoryInput> get copyWith =>
      throw _privateConstructorUsedError;
}
