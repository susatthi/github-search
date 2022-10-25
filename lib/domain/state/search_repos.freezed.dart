// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_repos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchReposState {
  int get totalCount => throw _privateConstructorUsedError;
  List<Repo> get items => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  String get queryString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchReposStateCopyWith<SearchReposState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposStateCopyWith<$Res> {
  factory $SearchReposStateCopyWith(
          SearchReposState value, $Res Function(SearchReposState) then) =
      _$SearchReposStateCopyWithImpl<$Res>;
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class _$SearchReposStateCopyWithImpl<$Res>
    implements $SearchReposStateCopyWith<$Res> {
  _$SearchReposStateCopyWithImpl(this._value, this._then);

  final SearchReposState _value;
  // ignore: unused_field
  final $Res Function(SearchReposState) _then;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? items = freezed,
    Object? hasNext = freezed,
    Object? page = freezed,
    Object? queryString = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SearchReposStateCopyWith<$Res>
    implements $SearchReposStateCopyWith<$Res> {
  factory _$$_SearchReposStateCopyWith(
          _$_SearchReposState value, $Res Function(_$_SearchReposState) then) =
      __$$_SearchReposStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class __$$_SearchReposStateCopyWithImpl<$Res>
    extends _$SearchReposStateCopyWithImpl<$Res>
    implements _$$_SearchReposStateCopyWith<$Res> {
  __$$_SearchReposStateCopyWithImpl(
      _$_SearchReposState _value, $Res Function(_$_SearchReposState) _then)
      : super(_value, (v) => _then(v as _$_SearchReposState));

  @override
  _$_SearchReposState get _value => super._value as _$_SearchReposState;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? items = freezed,
    Object? hasNext = freezed,
    Object? page = freezed,
    Object? queryString = freezed,
  }) {
    return _then(_$_SearchReposState(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
      hasNext: hasNext == freezed
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: queryString == freezed
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SearchReposState implements _SearchReposState {
  const _$_SearchReposState(
      {this.totalCount = 0,
      final List<Repo> items = const <Repo>[],
      this.hasNext = false,
      this.page = 1,
      this.queryString = ''})
      : _items = items;

  @override
  @JsonKey()
  final int totalCount;
  final List<Repo> _items;
  @override
  @JsonKey()
  List<Repo> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final String queryString;

  @override
  String toString() {
    return 'SearchReposState(totalCount: $totalCount, items: $items, hasNext: $hasNext, page: $page, queryString: $queryString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchReposState &&
            const DeepCollectionEquality()
                .equals(other.totalCount, totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other.hasNext, hasNext) &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.queryString, queryString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalCount),
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(hasNext),
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(queryString));

  @JsonKey(ignore: true)
  @override
  _$$_SearchReposStateCopyWith<_$_SearchReposState> get copyWith =>
      __$$_SearchReposStateCopyWithImpl<_$_SearchReposState>(this, _$identity);
}

abstract class _SearchReposState implements SearchReposState {
  const factory _SearchReposState(
      {final int totalCount,
      final List<Repo> items,
      final bool hasNext,
      final int page,
      final String queryString}) = _$_SearchReposState;

  @override
  int get totalCount;
  @override
  List<Repo> get items;
  @override
  bool get hasNext;
  @override
  int get page;
  @override
  String get queryString;
  @override
  @JsonKey(ignore: true)
  _$$_SearchReposStateCopyWith<_$_SearchReposState> get copyWith =>
      throw _privateConstructorUsedError;
}
