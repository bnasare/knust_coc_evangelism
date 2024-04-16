// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Leader _$LeaderFromJson(Map<String, dynamic> json) {
  return _Leader.fromJson(json);
}

/// @nodoc
mixin _$Leader {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderCopyWith<Leader> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderCopyWith<$Res> {
  factory $LeaderCopyWith(Leader value, $Res Function(Leader) then) =
      _$LeaderCopyWithImpl<$Res, Leader>;
  @useResult
  $Res call({String name, String email, String id});
}

/// @nodoc
class _$LeaderCopyWithImpl<$Res, $Val extends Leader>
    implements $LeaderCopyWith<$Res> {
  _$LeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderImplCopyWith<$Res> implements $LeaderCopyWith<$Res> {
  factory _$$LeaderImplCopyWith(
          _$LeaderImpl value, $Res Function(_$LeaderImpl) then) =
      __$$LeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String email, String id});
}

/// @nodoc
class __$$LeaderImplCopyWithImpl<$Res>
    extends _$LeaderCopyWithImpl<$Res, _$LeaderImpl>
    implements _$$LeaderImplCopyWith<$Res> {
  __$$LeaderImplCopyWithImpl(
      _$LeaderImpl _value, $Res Function(_$LeaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? id = null,
  }) {
    return _then(_$LeaderImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderImpl implements _Leader {
  const _$LeaderImpl(
      {required this.name, required this.email, required this.id});

  factory _$LeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String id;

  @override
  String toString() {
    return 'Leader(name: $name, email: $email, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderImplCopyWith<_$LeaderImpl> get copyWith =>
      __$$LeaderImplCopyWithImpl<_$LeaderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderImplToJson(
      this,
    );
  }
}

abstract class _Leader implements Leader {
  const factory _Leader(
      {required final String name,
      required final String email,
      required final String id}) = _$LeaderImpl;

  factory _Leader.fromJson(Map<String, dynamic> json) = _$LeaderImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$LeaderImplCopyWith<_$LeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
