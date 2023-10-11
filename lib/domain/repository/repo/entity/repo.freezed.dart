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

/// @nodoc
mixin _$Repo {
  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;

  /// アバターURL
  String get avatarUrl => throw _privateConstructorUsedError;

  /// オーナーURL
  String? get ownerUrl => throw _privateConstructorUsedError;

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;

  /// リポジトリ名（フル）
  String get fullName => throw _privateConstructorUsedError;

  /// 説明
  String? get description => throw _privateConstructorUsedError;

  /// スター数
  RepoCount get stargazersCount => throw _privateConstructorUsedError;

  /// ウォッチャー数
  RepoCount get watchersCount => throw _privateConstructorUsedError;

  /// プロジェクト言語
  RepoLanguage get language => throw _privateConstructorUsedError;

  /// フォーク数
  RepoCount get forksCount => throw _privateConstructorUsedError;

  /// Issue数
  RepoCount get openIssuesCount => throw _privateConstructorUsedError;

  /// デフォルトブランチ
  String get defaultBranch => throw _privateConstructorUsedError;

  /// リポジトリURL
  String? get repoUrl => throw _privateConstructorUsedError;

  /// スター数URL
  String? get stargazersUrl => throw _privateConstructorUsedError;

  /// ウォッチャー数URL
  String? get watchersUrl => throw _privateConstructorUsedError;

  /// フォーク数URL
  String? get forksUrl => throw _privateConstructorUsedError;

  /// Issue数URL
  String? get issuesUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoCopyWith<Repo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoCopyWith<$Res> {
  factory $RepoCopyWith(Repo value, $Res Function(Repo) then) =
      _$RepoCopyWithImpl<$Res, Repo>;
  @useResult
  $Res call(
      {String ownerName,
      String avatarUrl,
      String? ownerUrl,
      String repoName,
      String fullName,
      String? description,
      RepoCount stargazersCount,
      RepoCount watchersCount,
      RepoLanguage language,
      RepoCount forksCount,
      RepoCount openIssuesCount,
      String defaultBranch,
      String? repoUrl,
      String? stargazersUrl,
      String? watchersUrl,
      String? forksUrl,
      String? issuesUrl});

  $RepoCountCopyWith<$Res> get stargazersCount;
  $RepoCountCopyWith<$Res> get watchersCount;
  $RepoLanguageCopyWith<$Res> get language;
  $RepoCountCopyWith<$Res> get forksCount;
  $RepoCountCopyWith<$Res> get openIssuesCount;
}

/// @nodoc
class _$RepoCopyWithImpl<$Res, $Val extends Repo>
    implements $RepoCopyWith<$Res> {
  _$RepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerName = null,
    Object? avatarUrl = null,
    Object? ownerUrl = freezed,
    Object? repoName = null,
    Object? fullName = null,
    Object? description = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? language = null,
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
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUrl: freezed == ownerUrl
          ? _value.ownerUrl
          : ownerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as RepoLanguage,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
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
  $RepoCountCopyWith<$Res> get stargazersCount {
    return $RepoCountCopyWith<$Res>(_value.stargazersCount, (value) {
      return _then(_value.copyWith(stargazersCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RepoCountCopyWith<$Res> get watchersCount {
    return $RepoCountCopyWith<$Res>(_value.watchersCount, (value) {
      return _then(_value.copyWith(watchersCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RepoLanguageCopyWith<$Res> get language {
    return $RepoLanguageCopyWith<$Res>(_value.language, (value) {
      return _then(_value.copyWith(language: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RepoCountCopyWith<$Res> get forksCount {
    return $RepoCountCopyWith<$Res>(_value.forksCount, (value) {
      return _then(_value.copyWith(forksCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RepoCountCopyWith<$Res> get openIssuesCount {
    return $RepoCountCopyWith<$Res>(_value.openIssuesCount, (value) {
      return _then(_value.copyWith(openIssuesCount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepoImplCopyWith<$Res> implements $RepoCopyWith<$Res> {
  factory _$$RepoImplCopyWith(
          _$RepoImpl value, $Res Function(_$RepoImpl) then) =
      __$$RepoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ownerName,
      String avatarUrl,
      String? ownerUrl,
      String repoName,
      String fullName,
      String? description,
      RepoCount stargazersCount,
      RepoCount watchersCount,
      RepoLanguage language,
      RepoCount forksCount,
      RepoCount openIssuesCount,
      String defaultBranch,
      String? repoUrl,
      String? stargazersUrl,
      String? watchersUrl,
      String? forksUrl,
      String? issuesUrl});

  @override
  $RepoCountCopyWith<$Res> get stargazersCount;
  @override
  $RepoCountCopyWith<$Res> get watchersCount;
  @override
  $RepoLanguageCopyWith<$Res> get language;
  @override
  $RepoCountCopyWith<$Res> get forksCount;
  @override
  $RepoCountCopyWith<$Res> get openIssuesCount;
}

/// @nodoc
class __$$RepoImplCopyWithImpl<$Res>
    extends _$RepoCopyWithImpl<$Res, _$RepoImpl>
    implements _$$RepoImplCopyWith<$Res> {
  __$$RepoImplCopyWithImpl(_$RepoImpl _value, $Res Function(_$RepoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerName = null,
    Object? avatarUrl = null,
    Object? ownerUrl = freezed,
    Object? repoName = null,
    Object? fullName = null,
    Object? description = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? language = null,
    Object? forksCount = null,
    Object? openIssuesCount = null,
    Object? defaultBranch = null,
    Object? repoUrl = freezed,
    Object? stargazersUrl = freezed,
    Object? watchersUrl = freezed,
    Object? forksUrl = freezed,
    Object? issuesUrl = freezed,
  }) {
    return _then(_$RepoImpl(
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUrl: freezed == ownerUrl
          ? _value.ownerUrl
          : ownerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as RepoLanguage,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
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

class _$RepoImpl extends _Repo {
  const _$RepoImpl(
      {required this.ownerName,
      required this.avatarUrl,
      required this.ownerUrl,
      required this.repoName,
      required this.fullName,
      this.description,
      required this.stargazersCount,
      required this.watchersCount,
      required this.language,
      required this.forksCount,
      required this.openIssuesCount,
      required this.defaultBranch,
      this.repoUrl,
      this.stargazersUrl,
      this.watchersUrl,
      this.forksUrl,
      this.issuesUrl})
      : super._();

  /// オーナー名
  @override
  final String ownerName;

  /// アバターURL
  @override
  final String avatarUrl;

  /// オーナーURL
  @override
  final String? ownerUrl;

  /// リポジトリ名
  @override
  final String repoName;

  /// リポジトリ名（フル）
  @override
  final String fullName;

  /// 説明
  @override
  final String? description;

  /// スター数
  @override
  final RepoCount stargazersCount;

  /// ウォッチャー数
  @override
  final RepoCount watchersCount;

  /// プロジェクト言語
  @override
  final RepoLanguage language;

  /// フォーク数
  @override
  final RepoCount forksCount;

  /// Issue数
  @override
  final RepoCount openIssuesCount;

  /// デフォルトブランチ
  @override
  final String defaultBranch;

  /// リポジトリURL
  @override
  final String? repoUrl;

  /// スター数URL
  @override
  final String? stargazersUrl;

  /// ウォッチャー数URL
  @override
  final String? watchersUrl;

  /// フォーク数URL
  @override
  final String? forksUrl;

  /// Issue数URL
  @override
  final String? issuesUrl;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoImpl &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.ownerUrl, ownerUrl) ||
                other.ownerUrl == ownerUrl) &&
            (identical(other.repoName, repoName) ||
                other.repoName == repoName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType,
      ownerName,
      avatarUrl,
      ownerUrl,
      repoName,
      fullName,
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
  _$$RepoImplCopyWith<_$RepoImpl> get copyWith =>
      __$$RepoImplCopyWithImpl<_$RepoImpl>(this, _$identity);
}

abstract class _Repo extends Repo {
  const factory _Repo(
      {required final String ownerName,
      required final String avatarUrl,
      required final String? ownerUrl,
      required final String repoName,
      required final String fullName,
      final String? description,
      required final RepoCount stargazersCount,
      required final RepoCount watchersCount,
      required final RepoLanguage language,
      required final RepoCount forksCount,
      required final RepoCount openIssuesCount,
      required final String defaultBranch,
      final String? repoUrl,
      final String? stargazersUrl,
      final String? watchersUrl,
      final String? forksUrl,
      final String? issuesUrl}) = _$RepoImpl;
  const _Repo._() : super._();

  @override

  /// オーナー名
  String get ownerName;
  @override

  /// アバターURL
  String get avatarUrl;
  @override

  /// オーナーURL
  String? get ownerUrl;
  @override

  /// リポジトリ名
  String get repoName;
  @override

  /// リポジトリ名（フル）
  String get fullName;
  @override

  /// 説明
  String? get description;
  @override

  /// スター数
  RepoCount get stargazersCount;
  @override

  /// ウォッチャー数
  RepoCount get watchersCount;
  @override

  /// プロジェクト言語
  RepoLanguage get language;
  @override

  /// フォーク数
  RepoCount get forksCount;
  @override

  /// Issue数
  RepoCount get openIssuesCount;
  @override

  /// デフォルトブランチ
  String get defaultBranch;
  @override

  /// リポジトリURL
  String? get repoUrl;
  @override

  /// スター数URL
  String? get stargazersUrl;
  @override

  /// ウォッチャー数URL
  String? get watchersUrl;
  @override

  /// フォーク数URL
  String? get forksUrl;
  @override

  /// Issue数URL
  String? get issuesUrl;
  @override
  @JsonKey(ignore: true)
  _$$RepoImplCopyWith<_$RepoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
