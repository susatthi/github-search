// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'query_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QueryHistory {
  /// 検索文字列
  QueryString get queryString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QueryHistoryCopyWith<QueryHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryHistoryCopyWith<$Res> {
  factory $QueryHistoryCopyWith(
          QueryHistory value, $Res Function(QueryHistory) then) =
      _$QueryHistoryCopyWithImpl<$Res>;
  $Res call({QueryString queryString});

  $QueryStringCopyWith<$Res> get queryString;
}

/// @nodoc
class _$QueryHistoryCopyWithImpl<$Res> implements $QueryHistoryCopyWith<$Res> {
  _$QueryHistoryCopyWithImpl(this._value, this._then);

  final QueryHistory _value;
  // ignore: unused_field
  final $Res Function(QueryHistory) _then;

  @override
  $Res call({
    Object? queryString = freezed,
  }) {
    return _then(_value.copyWith(
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as QueryString,
    ));
  }

  @override
  $QueryStringCopyWith<$Res> get queryString {
    return $QueryStringCopyWith<$Res>(_value.queryString, (value) {
      return _then(_value.copyWith(queryString: value));
    });
  }
}

/// @nodoc
abstract class _$$_QueryHistoryCopyWith<$Res>
    implements $QueryHistoryCopyWith<$Res> {
  factory _$$_QueryHistoryCopyWith(
          _$_QueryHistory value, $Res Function(_$_QueryHistory) then) =
      __$$_QueryHistoryCopyWithImpl<$Res>;
  @override
  $Res call({QueryString queryString});

  @override
  $QueryStringCopyWith<$Res> get queryString;
}

/// @nodoc
class __$$_QueryHistoryCopyWithImpl<$Res>
    extends _$QueryHistoryCopyWithImpl<$Res>
    implements _$$_QueryHistoryCopyWith<$Res> {
  __$$_QueryHistoryCopyWithImpl(
      _$_QueryHistory _value, $Res Function(_$_QueryHistory) _then)
      : super(_value, (v) => _then(v as _$_QueryHistory));

  @override
  _$_QueryHistory get _value => super._value as _$_QueryHistory;

  @override
  $Res call({
    Object? queryString = freezed,
  }) {
    return _then(_$_QueryHistory(
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as QueryString,
    ));
  }
}

/// @nodoc

class _$_QueryHistory extends _QueryHistory {
  const _$_QueryHistory({required this.queryString}) : super._();

  /// 検索文字列
  @override
  final QueryString queryString;

  @override
  String toString() {
    return 'QueryHistory(queryString: $queryString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QueryHistory &&
            const DeepCollectionEquality()
                .equals(other.queryString, queryString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(queryString));

  @JsonKey(ignore: true)
  @override
  _$$_QueryHistoryCopyWith<_$_QueryHistory> get copyWith =>
      __$$_QueryHistoryCopyWithImpl<_$_QueryHistory>(this, _$identity);
}

abstract class _QueryHistory extends QueryHistory {
  const factory _QueryHistory({required final QueryString queryString}) =
      _$_QueryHistory;
  const _QueryHistory._() : super._();

  @override

  /// 検索文字列
  QueryString get queryString;
  @override
  @JsonKey(ignore: true)
  _$$_QueryHistoryCopyWith<_$_QueryHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
