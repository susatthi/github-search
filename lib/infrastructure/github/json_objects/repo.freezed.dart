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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepoJsonObject _$RepoJsonObjectFromJson(Map<String, dynamic> json) {
  return _RepoJsonObject.fromJson(json);
}

/// @nodoc
mixin _$RepoJsonObject {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  OwnerJsonObject get owner => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'stargazers_count')
  int get stargazersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'watchers_count')
  int get watchersCount => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'forks_count')
  int get forksCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_issues_count')
  int get openIssuesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_branch')
  String get defaultBranch => throw _privateConstructorUsedError;
  String? get repoUrl => throw _privateConstructorUsedError;
  String? get stargazersUrl => throw _privateConstructorUsedError;
  String? get watchersUrl => throw _privateConstructorUsedError;
  String? get forksUrl => throw _privateConstructorUsedError;
  String? get issuesUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoJsonObjectCopyWith<RepoJsonObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoJsonObjectCopyWith<$Res> {
  factory $RepoJsonObjectCopyWith(
          RepoJsonObject value, $Res Function(RepoJsonObject) then) =
      _$RepoJsonObjectCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @JsonKey(name: 'full_name') String fullName,
      OwnerJsonObject owner,
      String? description,
      @JsonKey(name: 'stargazers_count') int stargazersCount,
      @JsonKey(name: 'watchers_count') int watchersCount,
      String? language,
      @JsonKey(name: 'forks_count') int forksCount,
      @JsonKey(name: 'open_issues_count') int openIssuesCount,
      @JsonKey(name: 'default_branch') String defaultBranch,
      String? repoUrl,
      String? stargazersUrl,
      String? watchersUrl,
      String? forksUrl,
      String? issuesUrl});

  $OwnerJsonObjectCopyWith<$Res> get owner;
}

/// @nodoc
class _$RepoJsonObjectCopyWithImpl<$Res>
    implements $RepoJsonObjectCopyWith<$Res> {
  _$RepoJsonObjectCopyWithImpl(this._value, this._then);

  final RepoJsonObject _value;
  // ignore: unused_field
  final $Res Function(RepoJsonObject) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? fullName = freezed,
    Object? owner = freezed,
    Object? description = freezed,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
    Object? defaultBranch = freezed,
    Object? repoUrl = freezed,
    Object? stargazersUrl = freezed,
    Object? watchersUrl = freezed,
    Object? forksUrl = freezed,
    Object? issuesUrl = freezed,
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
              as OwnerJsonObject,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      defaultBranch: defaultBranch == freezed
          ? _value.defaultBranch
          : defaultBranch // ignore: cast_nullable_to_non_nullable
              as String,
      repoUrl: repoUrl == freezed
          ? _value.repoUrl
          : repoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersUrl: stargazersUrl == freezed
          ? _value.stargazersUrl
          : stargazersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watchersUrl: watchersUrl == freezed
          ? _value.watchersUrl
          : watchersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      forksUrl: forksUrl == freezed
          ? _value.forksUrl
          : forksUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesUrl: issuesUrl == freezed
          ? _value.issuesUrl
          : issuesUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $OwnerJsonObjectCopyWith<$Res> get owner {
    return $OwnerJsonObjectCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepoJsonObjectCopyWith<$Res>
    implements $RepoJsonObjectCopyWith<$Res> {
  factory _$$_RepoJsonObjectCopyWith(
          _$_RepoJsonObject value, $Res Function(_$_RepoJsonObject) then) =
      __$$_RepoJsonObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @JsonKey(name: 'full_name') String fullName,
      OwnerJsonObject owner,
      String? description,
      @JsonKey(name: 'stargazers_count') int stargazersCount,
      @JsonKey(name: 'watchers_count') int watchersCount,
      String? language,
      @JsonKey(name: 'forks_count') int forksCount,
      @JsonKey(name: 'open_issues_count') int openIssuesCount,
      @JsonKey(name: 'default_branch') String defaultBranch,
      String? repoUrl,
      String? stargazersUrl,
      String? watchersUrl,
      String? forksUrl,
      String? issuesUrl});

  @override
  $OwnerJsonObjectCopyWith<$Res> get owner;
}

/// @nodoc
class __$$_RepoJsonObjectCopyWithImpl<$Res>
    extends _$RepoJsonObjectCopyWithImpl<$Res>
    implements _$$_RepoJsonObjectCopyWith<$Res> {
  __$$_RepoJsonObjectCopyWithImpl(
      _$_RepoJsonObject _value, $Res Function(_$_RepoJsonObject) _then)
      : super(_value, (v) => _then(v as _$_RepoJsonObject));

  @override
  _$_RepoJsonObject get _value => super._value as _$_RepoJsonObject;

  @override
  $Res call({
    Object? name = freezed,
    Object? fullName = freezed,
    Object? owner = freezed,
    Object? description = freezed,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
    Object? defaultBranch = freezed,
    Object? repoUrl = freezed,
    Object? stargazersUrl = freezed,
    Object? watchersUrl = freezed,
    Object? forksUrl = freezed,
    Object? issuesUrl = freezed,
  }) {
    return _then(_$_RepoJsonObject(
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
              as OwnerJsonObject,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      defaultBranch: defaultBranch == freezed
          ? _value.defaultBranch
          : defaultBranch // ignore: cast_nullable_to_non_nullable
              as String,
      repoUrl: repoUrl == freezed
          ? _value.repoUrl
          : repoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersUrl: stargazersUrl == freezed
          ? _value.stargazersUrl
          : stargazersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watchersUrl: watchersUrl == freezed
          ? _value.watchersUrl
          : watchersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      forksUrl: forksUrl == freezed
          ? _value.forksUrl
          : forksUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesUrl: issuesUrl == freezed
          ? _value.issuesUrl
          : issuesUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RepoJsonObject implements _RepoJsonObject {
  const _$_RepoJsonObject(
      {required this.name,
      @JsonKey(name: 'full_name') required this.fullName,
      required this.owner,
      required this.description,
      @JsonKey(name: 'stargazers_count') required this.stargazersCount,
      @JsonKey(name: 'watchers_count') required this.watchersCount,
      this.language,
      @JsonKey(name: 'forks_count') required this.forksCount,
      @JsonKey(name: 'open_issues_count') required this.openIssuesCount,
      @JsonKey(name: 'default_branch') required this.defaultBranch,
      this.repoUrl,
      this.stargazersUrl,
      this.watchersUrl,
      this.forksUrl,
      this.issuesUrl});

  factory _$_RepoJsonObject.fromJson(Map<String, dynamic> json) =>
      _$$_RepoJsonObjectFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final OwnerJsonObject owner;
  @override
  final String? description;
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
  @JsonKey(name: 'default_branch')
  final String defaultBranch;
  @override
  final String? repoUrl;
  @override
  final String? stargazersUrl;
  @override
  final String? watchersUrl;
  @override
  final String? forksUrl;
  @override
  final String? issuesUrl;

  @override
  String toString() {
    return 'RepoJsonObject(name: $name, fullName: $fullName, owner: $owner, description: $description, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount, defaultBranch: $defaultBranch, repoUrl: $repoUrl, stargazersUrl: $stargazersUrl, watchersUrl: $watchersUrl, forksUrl: $forksUrl, issuesUrl: $issuesUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepoJsonObject &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.stargazersCount, stargazersCount) &&
            const DeepCollectionEquality()
                .equals(other.watchersCount, watchersCount) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality()
                .equals(other.forksCount, forksCount) &&
            const DeepCollectionEquality()
                .equals(other.openIssuesCount, openIssuesCount) &&
            const DeepCollectionEquality()
                .equals(other.defaultBranch, defaultBranch) &&
            const DeepCollectionEquality().equals(other.repoUrl, repoUrl) &&
            const DeepCollectionEquality()
                .equals(other.stargazersUrl, stargazersUrl) &&
            const DeepCollectionEquality()
                .equals(other.watchersUrl, watchersUrl) &&
            const DeepCollectionEquality().equals(other.forksUrl, forksUrl) &&
            const DeepCollectionEquality().equals(other.issuesUrl, issuesUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(stargazersCount),
      const DeepCollectionEquality().hash(watchersCount),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(forksCount),
      const DeepCollectionEquality().hash(openIssuesCount),
      const DeepCollectionEquality().hash(defaultBranch),
      const DeepCollectionEquality().hash(repoUrl),
      const DeepCollectionEquality().hash(stargazersUrl),
      const DeepCollectionEquality().hash(watchersUrl),
      const DeepCollectionEquality().hash(forksUrl),
      const DeepCollectionEquality().hash(issuesUrl));

  @JsonKey(ignore: true)
  @override
  _$$_RepoJsonObjectCopyWith<_$_RepoJsonObject> get copyWith =>
      __$$_RepoJsonObjectCopyWithImpl<_$_RepoJsonObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepoJsonObjectToJson(this);
  }
}

abstract class _RepoJsonObject implements RepoJsonObject {
  const factory _RepoJsonObject(
      {required final String name,
      @JsonKey(name: 'full_name') required final String fullName,
      required final OwnerJsonObject owner,
      required final String? description,
      @JsonKey(name: 'stargazers_count') required final int stargazersCount,
      @JsonKey(name: 'watchers_count') required final int watchersCount,
      final String? language,
      @JsonKey(name: 'forks_count') required final int forksCount,
      @JsonKey(name: 'open_issues_count') required final int openIssuesCount,
      @JsonKey(name: 'default_branch') required final String defaultBranch,
      final String? repoUrl,
      final String? stargazersUrl,
      final String? watchersUrl,
      final String? forksUrl,
      final String? issuesUrl}) = _$_RepoJsonObject;

  factory _RepoJsonObject.fromJson(Map<String, dynamic> json) =
      _$_RepoJsonObject.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @override
  OwnerJsonObject get owner => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'stargazers_count')
  int get stargazersCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'watchers_count')
  int get watchersCount => throw _privateConstructorUsedError;
  @override
  String? get language => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'forks_count')
  int get forksCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'open_issues_count')
  int get openIssuesCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'default_branch')
  String get defaultBranch => throw _privateConstructorUsedError;
  @override
  String? get repoUrl => throw _privateConstructorUsedError;
  @override
  String? get stargazersUrl => throw _privateConstructorUsedError;
  @override
  String? get watchersUrl => throw _privateConstructorUsedError;
  @override
  String? get forksUrl => throw _privateConstructorUsedError;
  @override
  String? get issuesUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepoJsonObjectCopyWith<_$_RepoJsonObject> get copyWith =>
      throw _privateConstructorUsedError;
}
