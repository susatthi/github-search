// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repo_list_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RepoListViewStateTearOff {
  const _$RepoListViewStateTearOff();

  _RepoListViewState call({required List<RepoData> items}) {
    return _RepoListViewState(
      items: items,
    );
  }
}

/// @nodoc
const $RepoListViewState = _$RepoListViewStateTearOff();

/// @nodoc
mixin _$RepoListViewState {
  List<RepoData> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepoListViewStateCopyWith<RepoListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoListViewStateCopyWith<$Res> {
  factory $RepoListViewStateCopyWith(
          RepoListViewState value, $Res Function(RepoListViewState) then) =
      _$RepoListViewStateCopyWithImpl<$Res>;
  $Res call({List<RepoData> items});
}

/// @nodoc
class _$RepoListViewStateCopyWithImpl<$Res>
    implements $RepoListViewStateCopyWith<$Res> {
  _$RepoListViewStateCopyWithImpl(this._value, this._then);

  final RepoListViewState _value;
  // ignore: unused_field
  final $Res Function(RepoListViewState) _then;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoData>,
    ));
  }
}

/// @nodoc
abstract class _$RepoListViewStateCopyWith<$Res>
    implements $RepoListViewStateCopyWith<$Res> {
  factory _$RepoListViewStateCopyWith(
          _RepoListViewState value, $Res Function(_RepoListViewState) then) =
      __$RepoListViewStateCopyWithImpl<$Res>;
  @override
  $Res call({List<RepoData> items});
}

/// @nodoc
class __$RepoListViewStateCopyWithImpl<$Res>
    extends _$RepoListViewStateCopyWithImpl<$Res>
    implements _$RepoListViewStateCopyWith<$Res> {
  __$RepoListViewStateCopyWithImpl(
      _RepoListViewState _value, $Res Function(_RepoListViewState) _then)
      : super(_value, (v) => _then(v as _RepoListViewState));

  @override
  _RepoListViewState get _value => super._value as _RepoListViewState;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_RepoListViewState(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepoData>,
    ));
  }
}

/// @nodoc

class _$_RepoListViewState implements _RepoListViewState {
  const _$_RepoListViewState({required this.items});

  @override
  final List<RepoData> items;

  @override
  String toString() {
    return 'RepoListViewState(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RepoListViewState &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$RepoListViewStateCopyWith<_RepoListViewState> get copyWith =>
      __$RepoListViewStateCopyWithImpl<_RepoListViewState>(this, _$identity);
}

abstract class _RepoListViewState implements RepoListViewState {
  const factory _RepoListViewState({required List<RepoData> items}) =
      _$_RepoListViewState;

  @override
  List<RepoData> get items;
  @override
  @JsonKey(ignore: true)
  _$RepoListViewStateCopyWith<_RepoListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
