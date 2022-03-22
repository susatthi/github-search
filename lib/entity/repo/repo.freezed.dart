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
      {required int id,
      required String name,
      @JsonKey(name: 'full_name') required String fullName}) {
    return _Repo(
      id: id,
      name: name,
      fullName: fullName,
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
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoCopyWith<Repo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoCopyWith<$Res> {
  factory $RepoCopyWith(Repo value, $Res Function(Repo) then) =
      _$RepoCopyWithImpl<$Res>;
  $Res call({int id, String name, @JsonKey(name: 'full_name') String fullName});
}

/// @nodoc
class _$RepoCopyWithImpl<$Res> implements $RepoCopyWith<$Res> {
  _$RepoCopyWithImpl(this._value, this._then);

  final Repo _value;
  // ignore: unused_field
  final $Res Function(Repo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RepoCopyWith<$Res> implements $RepoCopyWith<$Res> {
  factory _$RepoCopyWith(_Repo value, $Res Function(_Repo) then) =
      __$RepoCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, @JsonKey(name: 'full_name') String fullName});
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
    Object? id = freezed,
    Object? name = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_Repo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Repo implements _Repo {
  const _$_Repo(
      {required this.id,
      required this.name,
      @JsonKey(name: 'full_name') required this.fullName});

  factory _$_Repo.fromJson(Map<String, dynamic> json) => _$$_RepoFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;

  @override
  String toString() {
    return 'Repo(id: $id, name: $name, fullName: $fullName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Repo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fullName, fullName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fullName));

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
      {required int id,
      required String name,
      @JsonKey(name: 'full_name') required String fullName}) = _$_Repo;

  factory _Repo.fromJson(Map<String, dynamic> json) = _$_Repo.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(ignore: true)
  _$RepoCopyWith<_Repo> get copyWith => throw _privateConstructorUsedError;
}

ReposResult _$ReposResultFromJson(Map<String, dynamic> json) {
  return _ReposResult.fromJson(json);
}

/// @nodoc
class _$ReposResultTearOff {
  const _$ReposResultTearOff();

  _ReposResult call(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<Repo> items}) {
    return _ReposResult(
      totalCount: totalCount,
      incompleteResults: incompleteResults,
      items: items,
    );
  }

  ReposResult fromJson(Map<String, Object?> json) {
    return ReposResult.fromJson(json);
  }
}

/// @nodoc
const $ReposResult = _$ReposResultTearOff();

/// @nodoc
mixin _$ReposResult {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incomplete_results')
  bool get incompleteResults => throw _privateConstructorUsedError;
  List<Repo> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReposResultCopyWith<ReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReposResultCopyWith<$Res> {
  factory $ReposResultCopyWith(
          ReposResult value, $Res Function(ReposResult) then) =
      _$ReposResultCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<Repo> items});
}

/// @nodoc
class _$ReposResultCopyWithImpl<$Res> implements $ReposResultCopyWith<$Res> {
  _$ReposResultCopyWithImpl(this._value, this._then);

  final ReposResult _value;
  // ignore: unused_field
  final $Res Function(ReposResult) _then;

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
abstract class _$ReposResultCopyWith<$Res>
    implements $ReposResultCopyWith<$Res> {
  factory _$ReposResultCopyWith(
          _ReposResult value, $Res Function(_ReposResult) then) =
      __$ReposResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'incomplete_results') bool incompleteResults,
      List<Repo> items});
}

/// @nodoc
class __$ReposResultCopyWithImpl<$Res> extends _$ReposResultCopyWithImpl<$Res>
    implements _$ReposResultCopyWith<$Res> {
  __$ReposResultCopyWithImpl(
      _ReposResult _value, $Res Function(_ReposResult) _then)
      : super(_value, (v) => _then(v as _ReposResult));

  @override
  _ReposResult get _value => super._value as _ReposResult;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? incompleteResults = freezed,
    Object? items = freezed,
  }) {
    return _then(_ReposResult(
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
class _$_ReposResult implements _ReposResult {
  const _$_ReposResult(
      {@JsonKey(name: 'total_count') required this.totalCount,
      @JsonKey(name: 'incomplete_results') required this.incompleteResults,
      required this.items});

  factory _$_ReposResult.fromJson(Map<String, dynamic> json) =>
      _$$_ReposResultFromJson(json);

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
    return 'ReposResult(totalCount: $totalCount, incompleteResults: $incompleteResults, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReposResult &&
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
  _$ReposResultCopyWith<_ReposResult> get copyWith =>
      __$ReposResultCopyWithImpl<_ReposResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReposResultToJson(this);
  }
}

abstract class _ReposResult implements ReposResult {
  const factory _ReposResult(
      {@JsonKey(name: 'total_count') required int totalCount,
      @JsonKey(name: 'incomplete_results') required bool incompleteResults,
      required List<Repo> items}) = _$_ReposResult;

  factory _ReposResult.fromJson(Map<String, dynamic> json) =
      _$_ReposResult.fromJson;

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
  _$ReposResultCopyWith<_ReposResult> get copyWith =>
      throw _privateConstructorUsedError;
}
