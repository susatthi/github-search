// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepoResponse _$$_RepoResponseFromJson(Map<String, dynamic> json) =>
    _$_RepoResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
    );

Map<String, dynamic> _$$_RepoResponseToJson(_$_RepoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
    };

_$_SearchReposResultResponse _$$_SearchReposResultResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SearchReposResultResponse(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => RepoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SearchReposResultResponseToJson(
        _$_SearchReposResultResponse instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };
