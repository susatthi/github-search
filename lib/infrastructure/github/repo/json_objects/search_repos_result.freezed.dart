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

SearchReposResultJsonObject _$SearchReposResultJsonObjectFromJson(
    Map<String, dynamic> json) {
  return _SearchReposResultJsonObject.fromJson(json);
}

/// @nodoc
mixin _$SearchReposResultJsonObject {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  List<RepoJsonObject> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchReposResultJsonObjectCopyWith<SearchReposResultJsonObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposResultJsonObjectCopyWith<$Res> {
  factory $SearchReposResultJsonObjectCopyWith(
          SearchReposResultJsonObject value,
          $Res Function(SearchReposResultJsonObject) then) =
      _$SearchReposResultJsonObjectCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      List<RepoJsonObject> items});
}

/// @nodoc
class _$SearchReposResultJsonObjectCopyWithImpl<$Res>
    implements $SearchReposResultJsonObjectCopyWith<$Res> {
  _$SearchReposResultJsonObjectCopyWithImpl(this._value, this._then);

  final SearchReposResultJsonObject _value;
  // ignore: unused_field
  final $Res Function(SearchReposResultJsonObject) _then;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoJsonObject>,
    ));
  }
}

/// @nodoc
abstract class _$$_SearchReposResultJsonObjectCopyWith<$Res>
    implements $SearchReposResultJsonObjectCopyWith<$Res> {
  factory _$$_SearchReposResultJsonObjectCopyWith(
          _$_SearchReposResultJsonObject value,
          $Res Function(_$_SearchReposResultJsonObject) then) =
      __$$_SearchReposResultJsonObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      List<RepoJsonObject> items});
}

/// @nodoc
class __$$_SearchReposResultJsonObjectCopyWithImpl<$Res>
    extends _$SearchReposResultJsonObjectCopyWithImpl<$Res>
    implements _$$_SearchReposResultJsonObjectCopyWith<$Res> {
  __$$_SearchReposResultJsonObjectCopyWithImpl(
      _$_SearchReposResultJsonObject _value,
      $Res Function(_$_SearchReposResultJsonObject) _then)
      : super(_value, (v) => _then(v as _$_SearchReposResultJsonObject));

  @override
  _$_SearchReposResultJsonObject get _value =>
      super._value as _$_SearchReposResultJsonObject;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_SearchReposResultJsonObject(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoJsonObject>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchReposResultJsonObject implements _SearchReposResultJsonObject {
  const _$_SearchReposResultJsonObject(
      {@JsonKey(name: 'total_count') required this.totalCount,
      required final List<RepoJsonObject> items})
      : _items = items;

  factory _$_SearchReposResultJsonObject.fromJson(Map<String, dynamic> json) =>
      _$$_SearchReposResultJsonObjectFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<RepoJsonObject> _items;
  @override
  List<RepoJsonObject> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SearchReposResultJsonObject(totalCount: $totalCount, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchReposResultJsonObject &&
            const DeepCollectionEquality()
                .equals(other.totalCount, totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalCount),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_SearchReposResultJsonObjectCopyWith<_$_SearchReposResultJsonObject>
      get copyWith => __$$_SearchReposResultJsonObjectCopyWithImpl<
          _$_SearchReposResultJsonObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchReposResultJsonObjectToJson(this);
  }
}

abstract class _SearchReposResultJsonObject
    implements SearchReposResultJsonObject {
  const factory _SearchReposResultJsonObject(
          {@JsonKey(name: 'total_count') required final int totalCount,
          required final List<RepoJsonObject> items}) =
      _$_SearchReposResultJsonObject;

  factory _SearchReposResultJsonObject.fromJson(Map<String, dynamic> json) =
      _$_SearchReposResultJsonObject.fromJson;

  @override
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @override
  List<RepoJsonObject> get items => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SearchReposResultJsonObjectCopyWith<_$_SearchReposResultJsonObject>
      get copyWith => throw _privateConstructorUsedError;
}
