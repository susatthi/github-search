// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RepoParam {
  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get cache => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoParamCopyWith<RepoParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoParamCopyWith<$Res> {
  factory $RepoParamCopyWith(RepoParam value, $Res Function(RepoParam) then) =
      _$RepoParamCopyWithImpl<$Res, RepoParam>;
  @useResult
  $Res call({String ownerName, String repoName, Repo? cache});

  $RepoCopyWith<$Res>? get cache;
}

/// @nodoc
class _$RepoParamCopyWithImpl<$Res, $Val extends RepoParam>
    implements $RepoParamCopyWith<$Res> {
  _$RepoParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerName = null,
    Object? repoName = null,
    Object? cache = freezed,
  }) {
    return _then(_value.copyWith(
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      cache: freezed == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as Repo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RepoCopyWith<$Res>? get cache {
    if (_value.cache == null) {
      return null;
    }

    return $RepoCopyWith<$Res>(_value.cache!, (value) {
      return _then(_value.copyWith(cache: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepoParamImplCopyWith<$Res>
    implements $RepoParamCopyWith<$Res> {
  factory _$$RepoParamImplCopyWith(
          _$RepoParamImpl value, $Res Function(_$RepoParamImpl) then) =
      __$$RepoParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ownerName, String repoName, Repo? cache});

  @override
  $RepoCopyWith<$Res>? get cache;
}

/// @nodoc
class __$$RepoParamImplCopyWithImpl<$Res>
    extends _$RepoParamCopyWithImpl<$Res, _$RepoParamImpl>
    implements _$$RepoParamImplCopyWith<$Res> {
  __$$RepoParamImplCopyWithImpl(
      _$RepoParamImpl _value, $Res Function(_$RepoParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerName = null,
    Object? repoName = null,
    Object? cache = freezed,
  }) {
    return _then(_$RepoParamImpl(
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      cache: freezed == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as Repo?,
    ));
  }
}

/// @nodoc

class _$RepoParamImpl implements _RepoParam {
  const _$RepoParamImpl(
      {required this.ownerName, required this.repoName, this.cache});

  /// オーナー名
  @override
  final String ownerName;

  /// リポジトリ名
  @override
  final String repoName;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  @override
  final Repo? cache;

  @override
  String toString() {
    return 'RepoParam(ownerName: $ownerName, repoName: $repoName, cache: $cache)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoParamImpl &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.repoName, repoName) ||
                other.repoName == repoName) &&
            (identical(other.cache, cache) || other.cache == cache));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ownerName, repoName, cache);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoParamImplCopyWith<_$RepoParamImpl> get copyWith =>
      __$$RepoParamImplCopyWithImpl<_$RepoParamImpl>(this, _$identity);
}

abstract class _RepoParam implements RepoParam {
  const factory _RepoParam(
      {required final String ownerName,
      required final String repoName,
      final Repo? cache}) = _$RepoParamImpl;

  @override

  /// オーナー名
  String get ownerName;
  @override

  /// リポジトリ名
  String get repoName;
  @override

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get cache;
  @override
  @JsonKey(ignore: true)
  _$$RepoParamImplCopyWith<_$RepoParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
