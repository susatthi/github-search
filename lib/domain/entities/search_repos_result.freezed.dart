// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  String get query => throw _privateConstructorUsedError;

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
      _$SearchReposResultCopyWithImpl<$Res>;
  $Res call({int totalCount, String query, List<Repo> items});
}

/// @nodoc
class _$SearchReposResultCopyWithImpl<$Res>
    implements $SearchReposResultCopyWith<$Res> {
  _$SearchReposResultCopyWithImpl(this._value, this._then);

  final SearchReposResult _value;
  // ignore: unused_field
  final $Res Function(SearchReposResult) _then;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? query = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc
abstract class _$$_SearchReposResultCopyWith<$Res>
    implements $SearchReposResultCopyWith<$Res> {
  factory _$$_SearchReposResultCopyWith(_$_SearchReposResult value,
          $Res Function(_$_SearchReposResult) then) =
      __$$_SearchReposResultCopyWithImpl<$Res>;
  @override
  $Res call({int totalCount, String query, List<Repo> items});
}

/// @nodoc
class __$$_SearchReposResultCopyWithImpl<$Res>
    extends _$SearchReposResultCopyWithImpl<$Res>
    implements _$$_SearchReposResultCopyWith<$Res> {
  __$$_SearchReposResultCopyWithImpl(
      _$_SearchReposResult _value, $Res Function(_$_SearchReposResult) _then)
      : super(_value, (v) => _then(v as _$_SearchReposResult));

  @override
  _$_SearchReposResult get _value => super._value as _$_SearchReposResult;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? query = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_SearchReposResult(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc

class _$_SearchReposResult implements _SearchReposResult {
  const _$_SearchReposResult(
      {required this.totalCount,
      required this.query,
      required final List<Repo> items})
      : _items = items;

  /// 検索結果トータル件数
  @override
  final int totalCount;

  /// 検索文字列
  @override
  final String query;

  /// リポジトリEntityのリスト
  final List<Repo> _items;

  /// リポジトリEntityのリスト
  @override
  List<Repo> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SearchReposResult(totalCount: $totalCount, query: $query, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchReposResult &&
            const DeepCollectionEquality()
                .equals(other.totalCount, totalCount) &&
            const DeepCollectionEquality().equals(other.query, query) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalCount),
      const DeepCollectionEquality().hash(query),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_SearchReposResultCopyWith<_$_SearchReposResult> get copyWith =>
      __$$_SearchReposResultCopyWithImpl<_$_SearchReposResult>(
          this, _$identity);
}

abstract class _SearchReposResult implements SearchReposResult {
  const factory _SearchReposResult(
      {required final int totalCount,
      required final String query,
      required final List<Repo> items}) = _$_SearchReposResult;

  @override

  /// 検索結果トータル件数
  int get totalCount => throw _privateConstructorUsedError;
  @override

  /// 検索文字列
  String get query => throw _privateConstructorUsedError;
  @override

  /// リポジトリEntityのリスト
  List<Repo> get items => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SearchReposResultCopyWith<_$_SearchReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}
