// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetQueryHistoryCollectionCollection on Isar {
  IsarCollection<QueryHistoryCollection> get queryHistoryCollections =>
      getCollection();
}

const QueryHistoryCollectionSchema = CollectionSchema(
  name: 'QueryHistoryCollection',
  schema:
      '{"name":"QueryHistoryCollection","idName":"id","properties":[{"name":"queryString","type":"String"},{"name":"searchedAt","type":"Long"}],"indexes":[{"name":"searchedAt","unique":false,"properties":[{"name":"searchedAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'queryString': 0, 'searchedAt': 1},
  listProperties: {},
  indexIds: {'searchedAt': 0},
  indexValueTypes: {
    'searchedAt': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _queryHistoryCollectionGetId,
  setId: _queryHistoryCollectionSetId,
  getLinks: _queryHistoryCollectionGetLinks,
  attachLinks: _queryHistoryCollectionAttachLinks,
  serializeNative: _queryHistoryCollectionSerializeNative,
  deserializeNative: _queryHistoryCollectionDeserializeNative,
  deserializePropNative: _queryHistoryCollectionDeserializePropNative,
  serializeWeb: _queryHistoryCollectionSerializeWeb,
  deserializeWeb: _queryHistoryCollectionDeserializeWeb,
  deserializePropWeb: _queryHistoryCollectionDeserializePropWeb,
  version: 3,
);

int? _queryHistoryCollectionGetId(QueryHistoryCollection object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _queryHistoryCollectionSetId(QueryHistoryCollection object, int id) {
  object.id = id;
}

List<IsarLinkBase> _queryHistoryCollectionGetLinks(
    QueryHistoryCollection object) {
  return [];
}

void _queryHistoryCollectionSerializeNative(
    IsarCollection<QueryHistoryCollection> collection,
    IsarRawObject rawObj,
    QueryHistoryCollection object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.queryString;
  final _queryString = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_queryString.length) as int;
  final value1 = object.searchedAt;
  final _searchedAt = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _queryString);
  writer.writeDateTime(offsets[1], _searchedAt);
}

QueryHistoryCollection _queryHistoryCollectionDeserializeNative(
    IsarCollection<QueryHistoryCollection> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = QueryHistoryCollection();
  object.id = id;
  object.queryString = reader.readString(offsets[0]);
  object.searchedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _queryHistoryCollectionDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _queryHistoryCollectionSerializeWeb(
    IsarCollection<QueryHistoryCollection> collection,
    QueryHistoryCollection object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'queryString', object.queryString);
  IsarNative.jsObjectSet(
      jsObj, 'searchedAt', object.searchedAt.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

QueryHistoryCollection _queryHistoryCollectionDeserializeWeb(
    IsarCollection<QueryHistoryCollection> collection, dynamic jsObj) {
  final object = QueryHistoryCollection();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.queryString = IsarNative.jsObjectGet(jsObj, 'queryString') ?? '';
  object.searchedAt = IsarNative.jsObjectGet(jsObj, 'searchedAt') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'searchedAt'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  return object;
}

P _queryHistoryCollectionDeserializePropWeb<P>(
    Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'queryString':
      return (IsarNative.jsObjectGet(jsObj, 'queryString') ?? '') as P;
    case 'searchedAt':
      return (IsarNative.jsObjectGet(jsObj, 'searchedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'searchedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _queryHistoryCollectionAttachLinks(
    IsarCollection col, int id, QueryHistoryCollection object) {}

extension QueryHistoryCollectionQueryWhereSort
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QWhere> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterWhere>
      anySearchedAt() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'searchedAt'));
  }
}

extension QueryHistoryCollectionQueryWhere on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QWhereClause> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtEqualTo(DateTime searchedAt) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'searchedAt',
      value: [searchedAt],
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtNotEqualTo(DateTime searchedAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'searchedAt',
        upper: [searchedAt],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'searchedAt',
        lower: [searchedAt],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'searchedAt',
        lower: [searchedAt],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'searchedAt',
        upper: [searchedAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtGreaterThan(
    DateTime searchedAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'searchedAt',
      lower: [searchedAt],
      includeLower: include,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtLessThan(
    DateTime searchedAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'searchedAt',
      upper: [searchedAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtBetween(
    DateTime lowerSearchedAt,
    DateTime upperSearchedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'searchedAt',
      lower: [lowerSearchedAt],
      includeLower: includeLower,
      upper: [upperSearchedAt],
      includeUpper: includeUpper,
    ));
  }
}

extension QueryHistoryCollectionQueryFilter on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QFilterCondition> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'queryString',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
          QAfterFilterCondition>
      queryStringContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'queryString',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
          QAfterFilterCondition>
      queryStringMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'queryString',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'searchedAt',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'searchedAt',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'searchedAt',
      value: value,
    ));
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'searchedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension QueryHistoryCollectionQueryLinks on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QFilterCondition> {}

extension QueryHistoryCollectionQueryWhereSortBy
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QSortBy> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortByQueryString() {
    return addSortByInternal('queryString', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortByQueryStringDesc() {
    return addSortByInternal('queryString', Sort.desc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortBySearchedAt() {
    return addSortByInternal('searchedAt', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortBySearchedAtDesc() {
    return addSortByInternal('searchedAt', Sort.desc);
  }
}

extension QueryHistoryCollectionQueryWhereSortThenBy on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QSortThenBy> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByQueryString() {
    return addSortByInternal('queryString', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByQueryStringDesc() {
    return addSortByInternal('queryString', Sort.desc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenBySearchedAt() {
    return addSortByInternal('searchedAt', Sort.asc);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenBySearchedAtDesc() {
    return addSortByInternal('searchedAt', Sort.desc);
  }
}

extension QueryHistoryCollectionQueryWhereDistinct
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct>
      distinctByQueryString({bool caseSensitive = true}) {
    return addDistinctByInternal('queryString', caseSensitive: caseSensitive);
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct>
      distinctBySearchedAt() {
    return addDistinctByInternal('searchedAt');
  }
}

extension QueryHistoryCollectionQueryProperty on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QQueryProperty> {
  QueryBuilder<QueryHistoryCollection, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<QueryHistoryCollection, String, QQueryOperations>
      queryStringProperty() {
    return addPropertyNameInternal('queryString');
  }

  QueryBuilder<QueryHistoryCollection, DateTime, QQueryOperations>
      searchedAtProperty() {
    return addPropertyNameInternal('searchedAt');
  }
}
