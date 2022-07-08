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
      _$RepoCopyWithImpl<$Res>;
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
class _$RepoCopyWithImpl<$Res> implements $RepoCopyWith<$Res> {
  _$RepoCopyWithImpl(this._value, this._then);

  final Repo _value;
  // ignore: unused_field
  final $Res Function(Repo) _then;

  @override
  $Res call({
    Object? ownerName = freezed,
    Object? avatarUrl = freezed,
    Object? ownerUrl = freezed,
    Object? repoName = freezed,
    Object? fullName = freezed,
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
      ownerName: ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUrl: ownerUrl == freezed
          ? _value.ownerUrl
          : ownerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      repoName: repoName == freezed
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: stargazersCount == freezed
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      watchersCount: watchersCount == freezed
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as RepoLanguage,
      forksCount: forksCount == freezed
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      openIssuesCount: openIssuesCount == freezed
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
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
  $RepoCountCopyWith<$Res> get stargazersCount {
    return $RepoCountCopyWith<$Res>(_value.stargazersCount, (value) {
      return _then(_value.copyWith(stargazersCount: value));
    });
  }

  @override
  $RepoCountCopyWith<$Res> get watchersCount {
    return $RepoCountCopyWith<$Res>(_value.watchersCount, (value) {
      return _then(_value.copyWith(watchersCount: value));
    });
  }

  @override
  $RepoLanguageCopyWith<$Res> get language {
    return $RepoLanguageCopyWith<$Res>(_value.language, (value) {
      return _then(_value.copyWith(language: value));
    });
  }

  @override
  $RepoCountCopyWith<$Res> get forksCount {
    return $RepoCountCopyWith<$Res>(_value.forksCount, (value) {
      return _then(_value.copyWith(forksCount: value));
    });
  }

  @override
  $RepoCountCopyWith<$Res> get openIssuesCount {
    return $RepoCountCopyWith<$Res>(_value.openIssuesCount, (value) {
      return _then(_value.copyWith(openIssuesCount: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepoCopyWith<$Res> implements $RepoCopyWith<$Res> {
  factory _$$_RepoCopyWith(_$_Repo value, $Res Function(_$_Repo) then) =
      __$$_RepoCopyWithImpl<$Res>;
  @override
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
class __$$_RepoCopyWithImpl<$Res> extends _$RepoCopyWithImpl<$Res>
    implements _$$_RepoCopyWith<$Res> {
  __$$_RepoCopyWithImpl(_$_Repo _value, $Res Function(_$_Repo) _then)
      : super(_value, (v) => _then(v as _$_Repo));

  @override
  _$_Repo get _value => super._value as _$_Repo;

  @override
  $Res call({
    Object? ownerName = freezed,
    Object? avatarUrl = freezed,
    Object? ownerUrl = freezed,
    Object? repoName = freezed,
    Object? fullName = freezed,
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
    return _then(_$_Repo(
      ownerName: ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUrl: ownerUrl == freezed
          ? _value.ownerUrl
          : ownerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      repoName: repoName == freezed
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: stargazersCount == freezed
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      watchersCount: watchersCount == freezed
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as RepoLanguage,
      forksCount: forksCount == freezed
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
      openIssuesCount: openIssuesCount == freezed
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as RepoCount,
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

class _$_Repo extends _Repo {
  const _$_Repo(
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
            other is _$_Repo &&
            const DeepCollectionEquality().equals(other.ownerName, ownerName) &&
            const DeepCollectionEquality().equals(other.avatarUrl, avatarUrl) &&
            const DeepCollectionEquality().equals(other.ownerUrl, ownerUrl) &&
            const DeepCollectionEquality().equals(other.repoName, repoName) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ownerName),
      const DeepCollectionEquality().hash(avatarUrl),
      const DeepCollectionEquality().hash(ownerUrl),
      const DeepCollectionEquality().hash(repoName),
      const DeepCollectionEquality().hash(fullName),
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
  _$$_RepoCopyWith<_$_Repo> get copyWith =>
      __$$_RepoCopyWithImpl<_$_Repo>(this, _$identity);
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
      final String? issuesUrl}) = _$_Repo;
  const _Repo._() : super._();

  @override

  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;
  @override

  /// アバターURL
  String get avatarUrl => throw _privateConstructorUsedError;
  @override

  /// オーナーURL
  String? get ownerUrl => throw _privateConstructorUsedError;
  @override

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;
  @override

  /// リポジトリ名（フル）
  String get fullName => throw _privateConstructorUsedError;
  @override

  /// 説明
  String? get description => throw _privateConstructorUsedError;
  @override

  /// スター数
  RepoCount get stargazersCount => throw _privateConstructorUsedError;
  @override

  /// ウォッチャー数
  RepoCount get watchersCount => throw _privateConstructorUsedError;
  @override

  /// プロジェクト言語
  RepoLanguage get language => throw _privateConstructorUsedError;
  @override

  /// フォーク数
  RepoCount get forksCount => throw _privateConstructorUsedError;
  @override

  /// Issue数
  RepoCount get openIssuesCount => throw _privateConstructorUsedError;
  @override

  /// デフォルトブランチ
  String get defaultBranch => throw _privateConstructorUsedError;
  @override

  /// リポジトリURL
  String? get repoUrl => throw _privateConstructorUsedError;
  @override

  /// スター数URL
  String? get stargazersUrl => throw _privateConstructorUsedError;
  @override

  /// ウォッチャー数URL
  String? get watchersUrl => throw _privateConstructorUsedError;
  @override

  /// フォーク数URL
  String? get forksUrl => throw _privateConstructorUsedError;
  @override

  /// Issue数URL
  String? get issuesUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepoCopyWith<_$_Repo> get copyWith => throw _privateConstructorUsedError;
}
