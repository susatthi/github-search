// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return _Repo.fromJson(json);
}

/// @nodoc
class _$RepoTearOff {
  const _$RepoTearOff();

  _Repo call(
      {required String name,
      @JsonKey(name: 'full_name') required String fullName,
      required Owner owner,
      @JsonKey(name: 'stargazers_count') required int stargazersCount,
      @JsonKey(name: 'watchers_count') required int watchersCount,
      String? language,
      @JsonKey(name: 'forks_count') required int forksCount,
      @JsonKey(name: 'open_issues_count') required int openIssuesCount}) {
    return _Repo(
      name: name,
      fullName: fullName,
      owner: owner,
      stargazersCount: stargazersCount,
      watchersCount: watchersCount,
      language: language,
      forksCount: forksCount,
      openIssuesCount: openIssuesCount,
    );
  }

  Repo fromJson(Map<String, Object?> json) {
    return Repo.fromJson(json);
  }
}

/// @nodoc
const $Repo = _$RepoTearOff();

/// @nodoc
mixin _$Repo {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  Owner get owner => throw _privateConstructorUsedError;
  @JsonKey(name: 'stargazers_count')
  int get stargazersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'watchers_count')
  int get watchersCount => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'forks_count')
  int get forksCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_issues_count')
  int get openIssuesCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoCopyWith<Repo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoCopyWith<$Res> {
  factory $RepoCopyWith(Repo value, $Res Function(Repo) then) =
      _$RepoCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @JsonKey(name: 'full_name') String fullName,
      Owner owner,
      @JsonKey(name: 'stargazers_count') int stargazersCount,
      @JsonKey(name: 'watchers_count') int watchersCount,
      String? language,
      @JsonKey(name: 'forks_count') int forksCount,
      @JsonKey(name: 'open_issues_count') int openIssuesCount});

  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class _$RepoCopyWithImpl<$Res> implements $RepoCopyWith<$Res> {
  _$RepoCopyWithImpl(this._value, this._then);

  final Repo _value;
  // ignore: unused_field
  final $Res Function(Repo) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? fullName = freezed,
    Object? owner = freezed,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
      stargazersCount: stargazersCount == freezed
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: watchersCount == freezed
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: forksCount == freezed
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: openIssuesCount == freezed
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $OwnerCopyWith<$Res> get owner {
    return $OwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }
}

/// @nodoc
abstract class _$RepoCopyWith<$Res> implements $RepoCopyWith<$Res> {
  factory _$RepoCopyWith(_Repo value, $Res Function(_Repo) then) =
      __$RepoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @JsonKey(name: 'full_name') String fullName,
      Owner owner,
      @JsonKey(name: 'stargazers_count') int stargazersCount,
      @JsonKey(name: 'watchers_count') int watchersCount,
      String? language,
      @JsonKey(name: 'forks_count') int forksCount,
      @JsonKey(name: 'open_issues_count') int openIssuesCount});

  @override
  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class __$RepoCopyWithImpl<$Res> extends _$RepoCopyWithImpl<$Res>
    implements _$RepoCopyWith<$Res> {
  __$RepoCopyWithImpl(_Repo _value, $Res Function(_Repo) _then)
      : super(_value, (v) => _then(v as _Repo));

  @override
  _Repo get _value => super._value as _Repo;

  @override
  $Res call({
    Object? name = freezed,
    Object? fullName = freezed,
    Object? owner = freezed,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
  }) {
    return _then(_Repo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
      stargazersCount: stargazersCount == freezed
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: watchersCount == freezed
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: forksCount == freezed
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: openIssuesCount == freezed
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Repo implements _Repo {
  const _$_Repo(
      {required this.name,
      @JsonKey(name: 'full_name') required this.fullName,
      required this.owner,
      @JsonKey(name: 'stargazers_count') required this.stargazersCount,
      @JsonKey(name: 'watchers_count') required this.watchersCount,
      this.language,
      @JsonKey(name: 'forks_count') required this.forksCount,
      @JsonKey(name: 'open_issues_count') required this.openIssuesCount});

  factory _$_Repo.fromJson(Map<String, dynamic> json) => _$$_RepoFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final Owner owner;
  @override
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @override
  @JsonKey(name: 'watchers_count')
  final int watchersCount;
  @override
  final String? language;
  @override
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @override
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;

  @override
  String toString() {
    return 'Repo(name: $name, fullName: $fullName, owner: $owner, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Repo &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality()
                .equals(other.stargazersCount, stargazersCount) &&
            const DeepCollectionEquality()
                .equals(other.watchersCount, watchersCount) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality()
                .equals(other.forksCount, forksCount) &&
            const DeepCollectionEquality()
                .equals(other.openIssuesCount, openIssuesCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(stargazersCount),
      const DeepCollectionEquality().hash(watchersCount),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(forksCount),
      const DeepCollectionEquality().hash(openIssuesCount));

  @JsonKey(ignore: true)
  @override
  _$RepoCopyWith<_Repo> get copyWith =>
      __$RepoCopyWithImpl<_Repo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepoToJson(this);
  }
}

abstract class _Repo implements Repo {
  const factory _Repo(
          {required String name,
          @JsonKey(name: 'full_name') required String fullName,
          required Owner owner,
          @JsonKey(name: 'stargazers_count') required int stargazersCount,
          @JsonKey(name: 'watchers_count') required int watchersCount,
          String? language,
          @JsonKey(name: 'forks_count') required int forksCount,
          @JsonKey(name: 'open_issues_count') required int openIssuesCount}) =
      _$_Repo;

  factory _Repo.fromJson(Map<String, dynamic> json) = _$_Repo.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  Owner get owner;
  @override
  @JsonKey(name: 'stargazers_count')
  int get stargazersCount;
  @override
  @JsonKey(name: 'watchers_count')
  int get watchersCount;
  @override
  String? get language;
  @override
  @JsonKey(name: 'forks_count')
  int get forksCount;
  @override
  @JsonKey(name: 'open_issues_count')
  int get openIssuesCount;
  @override
  @JsonKey(ignore: true)
  _$RepoCopyWith<_Repo> get copyWith => throw _privateConstructorUsedError;
}

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
