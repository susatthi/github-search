// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_repos_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchReposResult {
  /// 検索結果トータル件数
  int get totalCount => throw _privateConstructorUsedError;

  /// 検索文字列
  String get queryString => throw _privateConstructorUsedError;

  /// リポジトリEntityのリスト
  List<Repo> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchReposResultCopyWith<SearchReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposResultCopyWith<$Res> {
  factory $SearchReposResultCopyWith(
          SearchReposResult value, $Res Function(SearchReposResult) then) =
      _$SearchReposResultCopyWithImpl<$Res, SearchReposResult>;
  @useResult
  $Res call({int totalCount, String queryString, List<Repo> items});
}

/// @nodoc
class _$SearchReposResultCopyWithImpl<$Res, $Val extends SearchReposResult>
    implements $SearchReposResultCopyWith<$Res> {
  _$SearchReposResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? queryString = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchReposResultImplCopyWith<$Res>
    implements $SearchReposResultCopyWith<$Res> {
  factory _$$SearchReposResultImplCopyWith(_$SearchReposResultImpl value,
          $Res Function(_$SearchReposResultImpl) then) =
      __$$SearchReposResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalCount, String queryString, List<Repo> items});
}

/// @nodoc
class __$$SearchReposResultImplCopyWithImpl<$Res>
    extends _$SearchReposResultCopyWithImpl<$Res, _$SearchReposResultImpl>
    implements _$$SearchReposResultImplCopyWith<$Res> {
  __$$SearchReposResultImplCopyWithImpl(_$SearchReposResultImpl _value,
      $Res Function(_$SearchReposResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? queryString = null,
    Object? items = null,
  }) {
    return _then(_$SearchReposResultImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc

class _$SearchReposResultImpl extends _SearchReposResult {
  const _$SearchReposResultImpl(
      {required this.totalCount,
      required this.queryString,
      required final List<Repo> items})
      : _items = items,
        super._();

  /// 検索結果トータル件数
  @override
  final int totalCount;

  /// 検索文字列
  @override
  final String queryString;

  /// リポジトリEntityのリスト
  final List<Repo> _items;

  /// リポジトリEntityのリスト
  @override
  List<Repo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SearchReposResult(totalCount: $totalCount, queryString: $queryString, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchReposResultImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.queryString, queryString) ||
                other.queryString == queryString) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalCount, queryString,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchReposResultImplCopyWith<_$SearchReposResultImpl> get copyWith =>
      __$$SearchReposResultImplCopyWithImpl<_$SearchReposResultImpl>(
          this, _$identity);
}

abstract class _SearchReposResult extends SearchReposResult {
  const factory _SearchReposResult(
      {required final int totalCount,
      required final String queryString,
      required final List<Repo> items}) = _$SearchReposResultImpl;
  const _SearchReposResult._() : super._();

  @override

  /// 検索結果トータル件数
  int get totalCount;
  @override

  /// 検索文字列
  String get queryString;
  @override

  /// リポジトリEntityのリスト
  List<Repo> get items;
  @override
  @JsonKey(ignore: true)
  _$$SearchReposResultImplCopyWith<_$SearchReposResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
