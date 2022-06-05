// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'selected_repo_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RepoSelectedRepoParameter {
  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get extra => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoSelectedRepoParameterCopyWith<RepoSelectedRepoParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoSelectedRepoParameterCopyWith<$Res> {
  factory $RepoSelectedRepoParameterCopyWith(RepoSelectedRepoParameter value,
          $Res Function(RepoSelectedRepoParameter) then) =
      _$RepoSelectedRepoParameterCopyWithImpl<$Res>;
  $Res call({String ownerName, String repoName, Repo? extra});

  $RepoCopyWith<$Res>? get extra;
}

/// @nodoc
class _$RepoSelectedRepoParameterCopyWithImpl<$Res>
    implements $RepoSelectedRepoParameterCopyWith<$Res> {
  _$RepoSelectedRepoParameterCopyWithImpl(this._value, this._then);

  final RepoSelectedRepoParameter _value;
  // ignore: unused_field
  final $Res Function(RepoSelectedRepoParameter) _then;

  @override
  $Res call({
    Object? ownerName = freezed,
    Object? repoName = freezed,
    Object? extra = freezed,
  }) {
    return _then(_value.copyWith(
      ownerName: ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      repoName: repoName == freezed
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      extra: extra == freezed
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Repo?,
    ));
  }

  @override
  $RepoCopyWith<$Res>? get extra {
    if (_value.extra == null) {
      return null;
    }

    return $RepoCopyWith<$Res>(_value.extra!, (value) {
      return _then(_value.copyWith(extra: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepoSelectedRepoParameterCopyWith<$Res>
    implements $RepoSelectedRepoParameterCopyWith<$Res> {
  factory _$$_RepoSelectedRepoParameterCopyWith(
          _$_RepoSelectedRepoParameter value,
          $Res Function(_$_RepoSelectedRepoParameter) then) =
      __$$_RepoSelectedRepoParameterCopyWithImpl<$Res>;
  @override
  $Res call({String ownerName, String repoName, Repo? extra});

  @override
  $RepoCopyWith<$Res>? get extra;
}

/// @nodoc
class __$$_RepoSelectedRepoParameterCopyWithImpl<$Res>
    extends _$RepoSelectedRepoParameterCopyWithImpl<$Res>
    implements _$$_RepoSelectedRepoParameterCopyWith<$Res> {
  __$$_RepoSelectedRepoParameterCopyWithImpl(
      _$_RepoSelectedRepoParameter _value,
      $Res Function(_$_RepoSelectedRepoParameter) _then)
      : super(_value, (v) => _then(v as _$_RepoSelectedRepoParameter));

  @override
  _$_RepoSelectedRepoParameter get _value =>
      super._value as _$_RepoSelectedRepoParameter;

  @override
  $Res call({
    Object? ownerName = freezed,
    Object? repoName = freezed,
    Object? extra = freezed,
  }) {
    return _then(_$_RepoSelectedRepoParameter(
      ownerName: ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      repoName: repoName == freezed
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      extra: extra == freezed
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Repo?,
    ));
  }
}

/// @nodoc

class _$_RepoSelectedRepoParameter implements _RepoSelectedRepoParameter {
  const _$_RepoSelectedRepoParameter(
      {required this.ownerName, required this.repoName, this.extra});

  /// オーナー名
  @override
  final String ownerName;

  /// リポジトリ名
  @override
  final String repoName;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  @override
  final Repo? extra;

  @override
  String toString() {
    return 'RepoSelectedRepoParameter(ownerName: $ownerName, repoName: $repoName, extra: $extra)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepoSelectedRepoParameter &&
            const DeepCollectionEquality().equals(other.ownerName, ownerName) &&
            const DeepCollectionEquality().equals(other.repoName, repoName) &&
            const DeepCollectionEquality().equals(other.extra, extra));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ownerName),
      const DeepCollectionEquality().hash(repoName),
      const DeepCollectionEquality().hash(extra));

  @JsonKey(ignore: true)
  @override
  _$$_RepoSelectedRepoParameterCopyWith<_$_RepoSelectedRepoParameter>
      get copyWith => __$$_RepoSelectedRepoParameterCopyWithImpl<
          _$_RepoSelectedRepoParameter>(this, _$identity);
}

abstract class _RepoSelectedRepoParameter implements RepoSelectedRepoParameter {
  const factory _RepoSelectedRepoParameter(
      {required final String ownerName,
      required final String repoName,
      final Repo? extra}) = _$_RepoSelectedRepoParameter;

  @override

  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;
  @override

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;
  @override

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get extra => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepoSelectedRepoParameterCopyWith<_$_RepoSelectedRepoParameter>
      get copyWith => throw _privateConstructorUsedError;
}
