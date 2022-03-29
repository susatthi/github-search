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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchReposResult _$SearchReposResultFromJson(Map<String, dynamic> json) {
  return _SearchReposResult.fromJson(json);
}

/// @nodoc
class _$SearchReposResultTearOff {
  const _$SearchReposResultTearOff();

  _SearchReposResult call(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<Repo> items}) {
    return _SearchReposResult(
      totalCount: totalCount,
      incompleteResults: incompleteResults,
      items: items,
    );
  }

  SearchReposResult fromJson(Map<String, Object?> json) {
    return SearchReposResult.fromJson(json);
  }
}

/// @nodoc
const $SearchReposResult = _$SearchReposResultTearOff();

/// @nodoc
mixin _$SearchReposResult {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incomplete_results')
  bool get incompleteResults => throw _privateConstructorUsedError;
  List<Repo> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchReposResultCopyWith<SearchReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposResultCopyWith<$Res> {
  factory $SearchReposResultCopyWith(
          SearchReposResult value, $Res Function(SearchReposResult) then) =
      _$SearchReposResultCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<Repo> items});
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
    Object? incompleteResults = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: incompleteResults == freezed
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc
abstract class _$SearchReposResultCopyWith<$Res>
    implements $SearchReposResultCopyWith<$Res> {
  factory _$SearchReposResultCopyWith(
          _SearchReposResult value, $Res Function(_SearchReposResult) then) =
      __$SearchReposResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<Repo> items});
}

/// @nodoc
class __$SearchReposResultCopyWithImpl<$Res>
    extends _$SearchReposResultCopyWithImpl<$Res>
    implements _$SearchReposResultCopyWith<$Res> {
  __$SearchReposResultCopyWithImpl(
      _SearchReposResult _value, $Res Function(_SearchReposResult) _then)
      : super(_value, (v) => _then(v as _SearchReposResult));

  @override
  _SearchReposResult get _value => super._value as _SearchReposResult;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? incompleteResults = freezed,
    Object? items = freezed,
  }) {
    return _then(_SearchReposResult(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: incompleteResults == freezed
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchReposResult implements _SearchReposResult {
  const _$_SearchReposResult(
      {@JsonKey(name: 'total_count') required this.totalCount,
      @JsonKey(name: 'incomplete_results') required this.incompleteResults,
      required this.items});

  factory _$_SearchReposResult.fromJson(Map<String, dynamic> json) =>
      _$$_SearchReposResultFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  @override
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;
  @override
  final List<Repo> items;

  @override
  String toString() {
    return 'SearchReposResult(totalCount: $totalCount, incompleteResults: $incompleteResults, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchReposResult &&
            const DeepCollectionEquality()
                .equals(other.totalCount, totalCount) &&
            const DeepCollectionEquality()
                .equals(other.incompleteResults, incompleteResults) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalCount),
      const DeepCollectionEquality().hash(incompleteResults),
      const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$SearchReposResultCopyWith<_SearchReposResult> get copyWith =>
      __$SearchReposResultCopyWithImpl<_SearchReposResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchReposResultToJson(this);
  }
}

abstract class _SearchReposResult implements SearchReposResult {
  const factory _SearchReposResult(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<Repo> items}) = _$_SearchReposResult;

  factory _SearchReposResult.fromJson(Map<String, dynamic> json) =
      _$_SearchReposResult.fromJson;

  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  @JsonKey(name: 'incomplete_results')
  bool get incompleteResults;
  @override
  List<Repo> get items;
  @override
  @JsonKey(ignore: true)
  _$SearchReposResultCopyWith<_SearchReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}
