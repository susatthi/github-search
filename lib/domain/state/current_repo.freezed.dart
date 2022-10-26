// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'current_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CurrentRepoParam {
  /// オーナー名
  String get ownerName => throw _privateConstructorUsedError;

  /// リポジトリ名
  String get repoName => throw _privateConstructorUsedError;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get extra => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentRepoParamCopyWith<CurrentRepoParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentRepoParamCopyWith<$Res> {
  factory $CurrentRepoParamCopyWith(
          CurrentRepoParam value, $Res Function(CurrentRepoParam) then) =
      _$CurrentRepoParamCopyWithImpl<$Res>;
  $Res call({String ownerName, String repoName, Repo? extra});

  $RepoCopyWith<$Res>? get extra;
}

/// @nodoc
class _$CurrentRepoParamCopyWithImpl<$Res>
    implements $CurrentRepoParamCopyWith<$Res> {
  _$CurrentRepoParamCopyWithImpl(this._value, this._then);

  final CurrentRepoParam _value;
  // ignore: unused_field
  final $Res Function(CurrentRepoParam) _then;

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
abstract class _$$_CurrentRepoParamCopyWith<$Res>
    implements $CurrentRepoParamCopyWith<$Res> {
  factory _$$_CurrentRepoParamCopyWith(
          _$_CurrentRepoParam value, $Res Function(_$_CurrentRepoParam) then) =
      __$$_CurrentRepoParamCopyWithImpl<$Res>;
  @override
  $Res call({String ownerName, String repoName, Repo? extra});

  @override
  $RepoCopyWith<$Res>? get extra;
}

/// @nodoc
class __$$_CurrentRepoParamCopyWithImpl<$Res>
    extends _$CurrentRepoParamCopyWithImpl<$Res>
    implements _$$_CurrentRepoParamCopyWith<$Res> {
  __$$_CurrentRepoParamCopyWithImpl(
      _$_CurrentRepoParam _value, $Res Function(_$_CurrentRepoParam) _then)
      : super(_value, (v) => _then(v as _$_CurrentRepoParam));

  @override
  _$_CurrentRepoParam get _value => super._value as _$_CurrentRepoParam;

  @override
  $Res call({
    Object? ownerName = freezed,
    Object? repoName = freezed,
    Object? extra = freezed,
  }) {
    return _then(_$_CurrentRepoParam(
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

class _$_CurrentRepoParam implements _CurrentRepoParam {
  const _$_CurrentRepoParam(
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
    return 'CurrentRepoParam(ownerName: $ownerName, repoName: $repoName, extra: $extra)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentRepoParam &&
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
  _$$_CurrentRepoParamCopyWith<_$_CurrentRepoParam> get copyWith =>
      __$$_CurrentRepoParamCopyWithImpl<_$_CurrentRepoParam>(this, _$identity);
}

abstract class _CurrentRepoParam implements CurrentRepoParam {
  const factory _CurrentRepoParam(
      {required final String ownerName,
      required final String repoName,
      final Repo? extra}) = _$_CurrentRepoParam;

  @override

  /// オーナー名
  String get ownerName;
  @override

  /// リポジトリ名
  String get repoName;
  @override

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  Repo? get extra;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentRepoParamCopyWith<_$_CurrentRepoParam> get copyWith =>
      throw _privateConstructorUsedError;
}
