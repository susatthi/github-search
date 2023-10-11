// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepoJsonObjectImpl _$$RepoJsonObjectImplFromJson(Map<String, dynamic> json) =>
    _$RepoJsonObjectImpl(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      owner: OwnerJsonObject.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      stargazersCount: json['stargazers_count'] as int,
      watchersCount: json['watchers_count'] as int,
      language: json['language'] as String?,
      forksCount: json['forks_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,
      defaultBranch: json['default_branch'] as String,
      repoUrl: json['repoUrl'] as String?,
      stargazersUrl: json['stargazersUrl'] as String?,
      watchersUrl: json['watchersUrl'] as String?,
      forksUrl: json['forksUrl'] as String?,
      issuesUrl: json['issuesUrl'] as String?,
    );

Map<String, dynamic> _$$RepoJsonObjectImplToJson(
        _$RepoJsonObjectImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'default_branch': instance.defaultBranch,
      'repoUrl': instance.repoUrl,
      'stargazersUrl': instance.stargazersUrl,
      'watchersUrl': instance.watchersUrl,
      'forksUrl': instance.forksUrl,
      'issuesUrl': instance.issuesUrl,
    };
