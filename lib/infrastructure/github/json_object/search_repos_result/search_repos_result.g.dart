// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repos_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchReposResultJsonObject _$$_SearchReposResultJsonObjectFromJson(
        Map<String, dynamic> json) =>
    _$_SearchReposResultJsonObject(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => RepoJsonObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SearchReposResultJsonObjectToJson(
        _$_SearchReposResultJsonObject instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };
