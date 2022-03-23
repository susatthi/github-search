// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepoResponse _$RepoResponseFromJson(Map<String, dynamic> json) {
  return _RepoResponse.fromJson(json);
}

/// @nodoc
class _$RepoResponseTearOff {
  const _$RepoResponseTearOff();

  _RepoResponse call(
      {required int id,
      required String name,
      @JsonKey(name: 'full_name') required String fullName}) {
    return _RepoResponse(
      id: id,
      name: name,
      fullName: fullName,
    );
  }

  RepoResponse fromJson(Map<String, Object?> json) {
    return RepoResponse.fromJson(json);
  }
}

/// @nodoc
const $RepoResponse = _$RepoResponseTearOff();

/// @nodoc
mixin _$RepoResponse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoResponseCopyWith<RepoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoResponseCopyWith<$Res> {
  factory $RepoResponseCopyWith(
          RepoResponse value, $Res Function(RepoResponse) then) =
      _$RepoResponseCopyWithImpl<$Res>;
  $Res call({int id, String name, @JsonKey(name: 'full_name') String fullName});
}

/// @nodoc
class _$RepoResponseCopyWithImpl<$Res> implements $RepoResponseCopyWith<$Res> {
  _$RepoResponseCopyWithImpl(this._value, this._then);

  final RepoResponse _value;
  // ignore: unused_field
  final $Res Function(RepoResponse) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RepoResponseCopyWith<$Res>
    implements $RepoResponseCopyWith<$Res> {
  factory _$RepoResponseCopyWith(
          _RepoResponse value, $Res Function(_RepoResponse) then) =
      __$RepoResponseCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, @JsonKey(name: 'full_name') String fullName});
}

/// @nodoc
class __$RepoResponseCopyWithImpl<$Res> extends _$RepoResponseCopyWithImpl<$Res>
    implements _$RepoResponseCopyWith<$Res> {
  __$RepoResponseCopyWithImpl(
      _RepoResponse _value, $Res Function(_RepoResponse) _then)
      : super(_value, (v) => _then(v as _RepoResponse));

  @override
  _RepoResponse get _value => super._value as _RepoResponse;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_RepoResponse(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RepoResponse implements _RepoResponse {
  const _$_RepoResponse(
      {required this.id,
      required this.name,
      @JsonKey(name: 'full_name') required this.fullName});

  factory _$_RepoResponse.fromJson(Map<String, dynamic> json) =>
      _$$_RepoResponseFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;

  @override
  String toString() {
    return 'RepoResponse(id: $id, name: $name, fullName: $fullName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RepoResponse &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fullName, fullName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fullName));

  @JsonKey(ignore: true)
  @override
  _$RepoResponseCopyWith<_RepoResponse> get copyWith =>
      __$RepoResponseCopyWithImpl<_RepoResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepoResponseToJson(this);
  }
}

abstract class _RepoResponse implements RepoResponse {
  const factory _RepoResponse(
      {required int id,
      required String name,
      @JsonKey(name: 'full_name') required String fullName}) = _$_RepoResponse;

  factory _RepoResponse.fromJson(Map<String, dynamic> json) =
      _$_RepoResponse.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(ignore: true)
  _$RepoResponseCopyWith<_RepoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchReposResultResponse _$SearchReposResultResponseFromJson(
    Map<String, dynamic> json) {
  return _SearchReposResultResponse.fromJson(json);
}

/// @nodoc
class _$SearchReposResultResponseTearOff {
  const _$SearchReposResultResponseTearOff();

  _SearchReposResultResponse call(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<RepoResponse> items}) {
    return _SearchReposResultResponse(
      totalCount: totalCount,
      incompleteResults: incompleteResults,
      items: items,
    );
  }

  SearchReposResultResponse fromJson(Map<String, Object?> json) {
    return SearchReposResultResponse.fromJson(json);
  }
}

/// @nodoc
const $SearchReposResultResponse = _$SearchReposResultResponseTearOff();

/// @nodoc
mixin _$SearchReposResultResponse {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incomplete_results')
  bool get incompleteResults => throw _privateConstructorUsedError;
  List<RepoResponse> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchReposResultResponseCopyWith<SearchReposResultResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposResultResponseCopyWith<$Res> {
  factory $SearchReposResultResponseCopyWith(SearchReposResultResponse value,
          $Res Function(SearchReposResultResponse) then) =
      _$SearchReposResultResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<RepoResponse> items});
}

/// @nodoc
class _$SearchReposResultResponseCopyWithImpl<$Res>
    implements $SearchReposResultResponseCopyWith<$Res> {
  _$SearchReposResultResponseCopyWithImpl(this._value, this._then);

  final SearchReposResultResponse _value;
  // ignore: unused_field
  final $Res Function(SearchReposResultResponse) _then;

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
              as List<RepoResponse>,
    ));
  }
}

/// @nodoc
abstract class _$SearchReposResultResponseCopyWith<$Res>
    implements $SearchReposResultResponseCopyWith<$Res> {
  factory _$SearchReposResultResponseCopyWith(_SearchReposResultResponse value,
          $Res Function(_SearchReposResultResponse) then) =
      __$SearchReposResultResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<RepoResponse> items});
}

/// @nodoc
class __$SearchReposResultResponseCopyWithImpl<$Res>
    extends _$SearchReposResultResponseCopyWithImpl<$Res>
    implements _$SearchReposResultResponseCopyWith<$Res> {
  __$SearchReposResultResponseCopyWithImpl(_SearchReposResultResponse _value,
      $Res Function(_SearchReposResultResponse) _then)
      : super(_value, (v) => _then(v as _SearchReposResultResponse));

  @override
  _SearchReposResultResponse get _value =>
      super._value as _SearchReposResultResponse;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? incompleteResults = freezed,
    Object? items = freezed,
  }) {
    return _then(_SearchReposResultResponse(
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
              as List<RepoResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchReposResultResponse implements _SearchReposResultResponse {
  const _$_SearchReposResultResponse(
      {@JsonKey(name: 'total_count') required this.totalCount,
      @JsonKey(name: 'incomplete_results') required this.incompleteResults,
      required this.items});

  factory _$_SearchReposResultResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SearchReposResultResponseFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  @override
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;
  @override
  final List<RepoResponse> items;

  @override
  String toString() {
    return 'SearchReposResultResponse(totalCount: $totalCount, incompleteResults: $incompleteResults, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchReposResultResponse &&
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
  _$SearchReposResultResponseCopyWith<_SearchReposResultResponse>
      get copyWith =>
          __$SearchReposResultResponseCopyWithImpl<_SearchReposResultResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchReposResultResponseToJson(this);
  }
}

abstract class _SearchReposResultResponse implements SearchReposResultResponse {
  const factory _SearchReposResultResponse(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<RepoResponse> items}) = _$_SearchReposResultResponse;

  factory _SearchReposResultResponse.fromJson(Map<String, dynamic> json) =
      _$_SearchReposResultResponse.fromJson;

  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  @JsonKey(name: 'incomplete_results')
  bool get incompleteResults;
  @override
  List<RepoResponse> get items;
  @override
  @JsonKey(ignore: true)
  _$SearchReposResultResponseCopyWith<_SearchReposResultResponse>
      get copyWith => throw _privateConstructorUsedError;
}
