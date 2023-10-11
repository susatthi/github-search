// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$QueryHistoryCopyWithImpl<$Res, QueryHistory>;
  @useResult
  $Res call({QueryString queryString});

  $QueryStringCopyWith<$Res> get queryString;
}

/// @nodoc
class _$QueryHistoryCopyWithImpl<$Res, $Val extends QueryHistory>
    implements $QueryHistoryCopyWith<$Res> {
  _$QueryHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queryString = null,
  }) {
    return _then(_value.copyWith(
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as QueryString,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QueryStringCopyWith<$Res> get queryString {
    return $QueryStringCopyWith<$Res>(_value.queryString, (value) {
      return _then(_value.copyWith(queryString: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueryHistoryImplCopyWith<$Res>
    implements $QueryHistoryCopyWith<$Res> {
  factory _$$QueryHistoryImplCopyWith(
          _$QueryHistoryImpl value, $Res Function(_$QueryHistoryImpl) then) =
      __$$QueryHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({QueryString queryString});

  @override
  $QueryStringCopyWith<$Res> get queryString;
}

/// @nodoc
class __$$QueryHistoryImplCopyWithImpl<$Res>
    extends _$QueryHistoryCopyWithImpl<$Res, _$QueryHistoryImpl>
    implements _$$QueryHistoryImplCopyWith<$Res> {
  __$$QueryHistoryImplCopyWithImpl(
      _$QueryHistoryImpl _value, $Res Function(_$QueryHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queryString = null,
  }) {
    return _then(_$QueryHistoryImpl(
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as QueryString,
    ));
  }
}

/// @nodoc

class _$QueryHistoryImpl extends _QueryHistory {
  const _$QueryHistoryImpl({required this.queryString}) : super._();

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
            other is _$QueryHistoryImpl &&
            (identical(other.queryString, queryString) ||
                other.queryString == queryString));
  }

  @override
  int get hashCode => Object.hash(runtimeType, queryString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryHistoryImplCopyWith<_$QueryHistoryImpl> get copyWith =>
      __$$QueryHistoryImplCopyWithImpl<_$QueryHistoryImpl>(this, _$identity);
}

abstract class _QueryHistory extends QueryHistory {
  const factory _QueryHistory({required final QueryString queryString}) =
      _$QueryHistoryImpl;
  const _QueryHistory._() : super._();

  @override

  /// 検索文字列
  QueryString get queryString;
  @override
  @JsonKey(ignore: true)
  _$$QueryHistoryImplCopyWith<_$QueryHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
