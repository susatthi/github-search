// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$RepoJsonObjectCopyWithImpl<$Res, RepoJsonObject>;
  @useResult
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
class _$RepoJsonObjectCopyWithImpl<$Res, $Val extends RepoJsonObject>
    implements $RepoJsonObjectCopyWith<$Res> {
  _$RepoJsonObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fullName = null,
    Object? owner = null,
    Object? description = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? language = freezed,
    Object? forksCount = null,
    Object? openIssuesCount = null,
    Object? defaultBranch = null,
    Object? repoUrl = freezed,
    Object? stargazersUrl = freezed,
    Object? watchersUrl = freezed,
    Object? forksUrl = freezed,
    Object? issuesUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as OwnerJsonObject,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultBranch: null == defaultBranch
          ? _value.defaultBranch
          : defaultBranch // ignore: cast_nullable_to_non_nullable
              as String,
      repoUrl: freezed == repoUrl
          ? _value.repoUrl
          : repoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersUrl: freezed == stargazersUrl
          ? _value.stargazersUrl
          : stargazersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watchersUrl: freezed == watchersUrl
          ? _value.watchersUrl
          : watchersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      forksUrl: freezed == forksUrl
          ? _value.forksUrl
          : forksUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesUrl: freezed == issuesUrl
          ? _value.issuesUrl
          : issuesUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OwnerJsonObjectCopyWith<$Res> get owner {
    return $OwnerJsonObjectCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepoJsonObjectImplCopyWith<$Res>
    implements $RepoJsonObjectCopyWith<$Res> {
  factory _$$RepoJsonObjectImplCopyWith(_$RepoJsonObjectImpl value,
          $Res Function(_$RepoJsonObjectImpl) then) =
      __$$RepoJsonObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
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
class __$$RepoJsonObjectImplCopyWithImpl<$Res>
    extends _$RepoJsonObjectCopyWithImpl<$Res, _$RepoJsonObjectImpl>
    implements _$$RepoJsonObjectImplCopyWith<$Res> {
  __$$RepoJsonObjectImplCopyWithImpl(
      _$RepoJsonObjectImpl _value, $Res Function(_$RepoJsonObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fullName = null,
    Object? owner = null,
    Object? description = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? language = freezed,
    Object? forksCount = null,
    Object? openIssuesCount = null,
    Object? defaultBranch = null,
    Object? repoUrl = freezed,
    Object? stargazersUrl = freezed,
    Object? watchersUrl = freezed,
    Object? forksUrl = freezed,
    Object? issuesUrl = freezed,
  }) {
    return _then(_$RepoJsonObjectImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as OwnerJsonObject,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultBranch: null == defaultBranch
          ? _value.defaultBranch
          : defaultBranch // ignore: cast_nullable_to_non_nullable
              as String,
      repoUrl: freezed == repoUrl
          ? _value.repoUrl
          : repoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersUrl: freezed == stargazersUrl
          ? _value.stargazersUrl
          : stargazersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watchersUrl: freezed == watchersUrl
          ? _value.watchersUrl
          : watchersUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      forksUrl: freezed == forksUrl
          ? _value.forksUrl
          : forksUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesUrl: freezed == issuesUrl
          ? _value.issuesUrl
          : issuesUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepoJsonObjectImpl implements _RepoJsonObject {
  const _$RepoJsonObjectImpl(
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

  factory _$RepoJsonObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoJsonObjectImplFromJson(json);

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
            other is _$RepoJsonObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.stargazersCount, stargazersCount) ||
                other.stargazersCount == stargazersCount) &&
            (identical(other.watchersCount, watchersCount) ||
                other.watchersCount == watchersCount) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.forksCount, forksCount) ||
                other.forksCount == forksCount) &&
            (identical(other.openIssuesCount, openIssuesCount) ||
                other.openIssuesCount == openIssuesCount) &&
            (identical(other.defaultBranch, defaultBranch) ||
                other.defaultBranch == defaultBranch) &&
            (identical(other.repoUrl, repoUrl) || other.repoUrl == repoUrl) &&
            (identical(other.stargazersUrl, stargazersUrl) ||
                other.stargazersUrl == stargazersUrl) &&
            (identical(other.watchersUrl, watchersUrl) ||
                other.watchersUrl == watchersUrl) &&
            (identical(other.forksUrl, forksUrl) ||
                other.forksUrl == forksUrl) &&
            (identical(other.issuesUrl, issuesUrl) ||
                other.issuesUrl == issuesUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      fullName,
      owner,
      description,
      stargazersCount,
      watchersCount,
      language,
      forksCount,
      openIssuesCount,
      defaultBranch,
      repoUrl,
      stargazersUrl,
      watchersUrl,
      forksUrl,
      issuesUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoJsonObjectImplCopyWith<_$RepoJsonObjectImpl> get copyWith =>
      __$$RepoJsonObjectImplCopyWithImpl<_$RepoJsonObjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepoJsonObjectImplToJson(
      this,
    );
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
      final String? issuesUrl}) = _$RepoJsonObjectImpl;

  factory _RepoJsonObject.fromJson(Map<String, dynamic> json) =
      _$RepoJsonObjectImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  OwnerJsonObject get owner;
  @override
  String? get description;
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
  @JsonKey(name: 'default_branch')
  String get defaultBranch;
  @override
  String? get repoUrl;
  @override
  String? get stargazersUrl;
  @override
  String? get watchersUrl;
  @override
  String? get forksUrl;
  @override
  String? get issuesUrl;
  @override
  @JsonKey(ignore: true)
  _$$RepoJsonObjectImplCopyWith<_$RepoJsonObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
