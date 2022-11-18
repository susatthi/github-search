// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReposState {
  int get totalCount => throw _privateConstructorUsedError;
  List<Repo> get items => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  String get queryString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReposStateCopyWith<ReposState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReposStateCopyWith<$Res> {
  factory $ReposStateCopyWith(
          ReposState value, $Res Function(ReposState) then) =
      _$ReposStateCopyWithImpl<$Res>;
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class _$ReposStateCopyWithImpl<$Res> implements $ReposStateCopyWith<$Res> {
  _$ReposStateCopyWithImpl(this._value, this._then);

  final ReposState _value;
  // ignore: unused_field
  final $Res Function(ReposState) _then;

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
abstract class _$$_ReposStateCopyWith<$Res>
    implements $ReposStateCopyWith<$Res> {
  factory _$$_ReposStateCopyWith(
          _$_ReposState value, $Res Function(_$_ReposState) then) =
      __$$_ReposStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class __$$_ReposStateCopyWithImpl<$Res> extends _$ReposStateCopyWithImpl<$Res>
    implements _$$_ReposStateCopyWith<$Res> {
  __$$_ReposStateCopyWithImpl(
      _$_ReposState _value, $Res Function(_$_ReposState) _then)
      : super(_value, (v) => _then(v as _$_ReposState));

  @override
  _$_ReposState get _value => super._value as _$_ReposState;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? items = freezed,
    Object? hasNext = freezed,
    Object? page = freezed,
    Object? queryString = freezed,
  }) {
    return _then(_$_ReposState(
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

class _$_ReposState implements _ReposState {
  const _$_ReposState(
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
    return 'ReposState(totalCount: $totalCount, items: $items, hasNext: $hasNext, page: $page, queryString: $queryString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReposState &&
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
  _$$_ReposStateCopyWith<_$_ReposState> get copyWith =>
      __$$_ReposStateCopyWithImpl<_$_ReposState>(this, _$identity);
}

abstract class _ReposState implements ReposState {
  const factory _ReposState(
      {final int totalCount,
      final List<Repo> items,
      final bool hasNext,
      final int page,
      final String queryString}) = _$_ReposState;

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
  _$$_ReposStateCopyWith<_$_ReposState> get copyWith =>
      throw _privateConstructorUsedError;
}
