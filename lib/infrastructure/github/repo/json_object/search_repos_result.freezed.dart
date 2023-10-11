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
      _$SearchReposResultJsonObjectCopyWithImpl<$Res,
          SearchReposResultJsonObject>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      List<RepoJsonObject> items});
}

/// @nodoc
class _$SearchReposResultJsonObjectCopyWithImpl<$Res,
        $Val extends SearchReposResultJsonObject>
    implements $SearchReposResultJsonObjectCopyWith<$Res> {
  _$SearchReposResultJsonObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoJsonObject>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchReposResultJsonObjectImplCopyWith<$Res>
    implements $SearchReposResultJsonObjectCopyWith<$Res> {
  factory _$$SearchReposResultJsonObjectImplCopyWith(
          _$SearchReposResultJsonObjectImpl value,
          $Res Function(_$SearchReposResultJsonObjectImpl) then) =
      __$$SearchReposResultJsonObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      List<RepoJsonObject> items});
}

/// @nodoc
class __$$SearchReposResultJsonObjectImplCopyWithImpl<$Res>
    extends _$SearchReposResultJsonObjectCopyWithImpl<$Res,
        _$SearchReposResultJsonObjectImpl>
    implements _$$SearchReposResultJsonObjectImplCopyWith<$Res> {
  __$$SearchReposResultJsonObjectImplCopyWithImpl(
      _$SearchReposResultJsonObjectImpl _value,
      $Res Function(_$SearchReposResultJsonObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_$SearchReposResultJsonObjectImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoJsonObject>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchReposResultJsonObjectImpl
    implements _SearchReposResultJsonObject {
  const _$SearchReposResultJsonObjectImpl(
      {@JsonKey(name: 'total_count') required this.totalCount,
      required final List<RepoJsonObject> items})
      : _items = items;

  factory _$SearchReposResultJsonObjectImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SearchReposResultJsonObjectImplFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<RepoJsonObject> _items;
  @override
  List<RepoJsonObject> get items {
    if (_items is EqualUnmodifiableListView) return _items;
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
            other is _$SearchReposResultJsonObjectImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalCount, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchReposResultJsonObjectImplCopyWith<_$SearchReposResultJsonObjectImpl>
      get copyWith => __$$SearchReposResultJsonObjectImplCopyWithImpl<
          _$SearchReposResultJsonObjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchReposResultJsonObjectImplToJson(
      this,
    );
  }
}

abstract class _SearchReposResultJsonObject
    implements SearchReposResultJsonObject {
  const factory _SearchReposResultJsonObject(
          {@JsonKey(name: 'total_count') required final int totalCount,
          required final List<RepoJsonObject> items}) =
      _$SearchReposResultJsonObjectImpl;

  factory _SearchReposResultJsonObject.fromJson(Map<String, dynamic> json) =
      _$SearchReposResultJsonObjectImpl.fromJson;

  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  List<RepoJsonObject> get items;
  @override
  @JsonKey(ignore: true)
  _$$SearchReposResultJsonObjectImplCopyWith<_$SearchReposResultJsonObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}
