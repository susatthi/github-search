// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$ReposStateCopyWithImpl<$Res, ReposState>;
  @useResult
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class _$ReposStateCopyWithImpl<$Res, $Val extends ReposState>
    implements $ReposStateCopyWith<$Res> {
  _$ReposStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
    Object? hasNext = null,
    Object? page = null,
    Object? queryString = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReposStateImplCopyWith<$Res>
    implements $ReposStateCopyWith<$Res> {
  factory _$$ReposStateImplCopyWith(
          _$ReposStateImpl value, $Res Function(_$ReposStateImpl) then) =
      __$$ReposStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalCount,
      List<Repo> items,
      bool hasNext,
      int page,
      String queryString});
}

/// @nodoc
class __$$ReposStateImplCopyWithImpl<$Res>
    extends _$ReposStateCopyWithImpl<$Res, _$ReposStateImpl>
    implements _$$ReposStateImplCopyWith<$Res> {
  __$$ReposStateImplCopyWithImpl(
      _$ReposStateImpl _value, $Res Function(_$ReposStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
    Object? hasNext = null,
    Object? page = null,
    Object? queryString = null,
  }) {
    return _then(_$ReposStateImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      queryString: null == queryString
          ? _value.queryString
          : queryString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReposStateImpl implements _ReposState {
  const _$ReposStateImpl(
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
    if (_items is EqualUnmodifiableListView) return _items;
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
            other is _$ReposStateImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.queryString, queryString) ||
                other.queryString == queryString));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalCount,
      const DeepCollectionEquality().hash(_items), hasNext, page, queryString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReposStateImplCopyWith<_$ReposStateImpl> get copyWith =>
      __$$ReposStateImplCopyWithImpl<_$ReposStateImpl>(this, _$identity);
}

abstract class _ReposState implements ReposState {
  const factory _ReposState(
      {final int totalCount,
      final List<Repo> items,
      final bool hasNext,
      final int page,
      final String queryString}) = _$ReposStateImpl;

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
  _$$ReposStateImplCopyWith<_$ReposStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
