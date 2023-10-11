// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'query_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQueryHistoryCollectionCollection on Isar {
  IsarCollection<QueryHistoryCollection> get queryHistoryCollections =>
      this.collection();
}

const QueryHistoryCollectionSchema = CollectionSchema(
  name: r'QueryHistoryCollection',
  id: -7581912548881788597,
  properties: {
    r'queryString': PropertySchema(
      id: 0,
      name: r'queryString',
      type: IsarType.string,
    ),
    r'searchedAt': PropertySchema(
      id: 1,
      name: r'searchedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _queryHistoryCollectionEstimateSize,
  serialize: _queryHistoryCollectionSerialize,
  deserialize: _queryHistoryCollectionDeserialize,
  deserializeProp: _queryHistoryCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'searchedAt': IndexSchema(
      id: 4437879492455379665,
      name: r'searchedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _queryHistoryCollectionGetId,
  getLinks: _queryHistoryCollectionGetLinks,
  attach: _queryHistoryCollectionAttach,
  version: '3.1.0+1',
);

int _queryHistoryCollectionEstimateSize(
  QueryHistoryCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.queryString.length * 3;
  return bytesCount;
}

void _queryHistoryCollectionSerialize(
  QueryHistoryCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.queryString);
  writer.writeDateTime(offsets[1], object.searchedAt);
}

QueryHistoryCollection _queryHistoryCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QueryHistoryCollection();
  object.id = id;
  object.queryString = reader.readString(offsets[0]);
  object.searchedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _queryHistoryCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _queryHistoryCollectionGetId(QueryHistoryCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _queryHistoryCollectionGetLinks(
    QueryHistoryCollection object) {
  return [];
}

void _queryHistoryCollectionAttach(
    IsarCollection<dynamic> col, Id id, QueryHistoryCollection object) {
  object.id = id;
}

extension QueryHistoryCollectionQueryWhereSort
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QWhere> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterWhere>
      anySearchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'searchedAt'),
      );
    });
  }
}

extension QueryHistoryCollectionQueryWhere on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QWhereClause> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtEqualTo(DateTime searchedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchedAt',
        value: [searchedAt],
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtNotEqualTo(DateTime searchedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchedAt',
              lower: [],
              upper: [searchedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchedAt',
              lower: [searchedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchedAt',
              lower: [searchedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchedAt',
              lower: [],
              upper: [searchedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtGreaterThan(
    DateTime searchedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchedAt',
        lower: [searchedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtLessThan(
    DateTime searchedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchedAt',
        lower: [],
        upper: [searchedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterWhereClause> searchedAtBetween(
    DateTime lowerSearchedAt,
    DateTime upperSearchedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchedAt',
        lower: [lowerSearchedAt],
        includeLower: includeLower,
        upper: [upperSearchedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QueryHistoryCollectionQueryFilter on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QFilterCondition> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'queryString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
          QAfterFilterCondition>
      queryStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'queryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
          QAfterFilterCondition>
      queryStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'queryString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'queryString',
        value: '',
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> queryStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'queryString',
        value: '',
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection,
      QAfterFilterCondition> searchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QueryHistoryCollectionQueryObject on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QFilterCondition> {}

extension QueryHistoryCollectionQueryLinks on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QFilterCondition> {}

extension QueryHistoryCollectionQuerySortBy
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QSortBy> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortByQueryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryString', Sort.asc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortByQueryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryString', Sort.desc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortBySearchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchedAt', Sort.asc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      sortBySearchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchedAt', Sort.desc);
    });
  }
}

extension QueryHistoryCollectionQuerySortThenBy on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QSortThenBy> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByQueryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryString', Sort.asc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenByQueryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'queryString', Sort.desc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenBySearchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchedAt', Sort.asc);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterSortBy>
      thenBySearchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchedAt', Sort.desc);
    });
  }
}

extension QueryHistoryCollectionQueryWhereDistinct
    on QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct> {
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct>
      distinctByQueryString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'queryString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QDistinct>
      distinctBySearchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchedAt');
    });
  }
}

extension QueryHistoryCollectionQueryProperty on QueryBuilder<
    QueryHistoryCollection, QueryHistoryCollection, QQueryProperty> {
  QueryBuilder<QueryHistoryCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QueryHistoryCollection, String, QQueryOperations>
      queryStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'queryString');
    });
  }

  QueryBuilder<QueryHistoryCollection, DateTime, QQueryOperations>
      searchedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchedAt');
    });
  }
}
