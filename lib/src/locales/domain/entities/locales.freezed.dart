// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locales.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Locales _$LocalesFromJson(Map<String, dynamic> json) {
  return _Locales.fromJson(json);
}

/// @nodoc
mixin _$Locales {
  String get name => throw _privateConstructorUsedError;
  String get timeframe => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalesCopyWith<Locales> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalesCopyWith<$Res> {
  factory $LocalesCopyWith(Locales value, $Res Function(Locales) then) =
      _$LocalesCopyWithImpl<$Res, Locales>;
  @useResult
  $Res call(
      {String name,
      String timeframe,
      String id,
      String status,
      DateTime? createdAt});
}

/// @nodoc
class _$LocalesCopyWithImpl<$Res, $Val extends Locales>
    implements $LocalesCopyWith<$Res> {
  _$LocalesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? timeframe = null,
    Object? id = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalesImplCopyWith<$Res> implements $LocalesCopyWith<$Res> {
  factory _$$LocalesImplCopyWith(
          _$LocalesImpl value, $Res Function(_$LocalesImpl) then) =
      __$$LocalesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String timeframe,
      String id,
      String status,
      DateTime? createdAt});
}

/// @nodoc
class __$$LocalesImplCopyWithImpl<$Res>
    extends _$LocalesCopyWithImpl<$Res, _$LocalesImpl>
    implements _$$LocalesImplCopyWith<$Res> {
  __$$LocalesImplCopyWithImpl(
      _$LocalesImpl _value, $Res Function(_$LocalesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? timeframe = null,
    Object? id = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$LocalesImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalesImpl implements _Locales {
  const _$LocalesImpl(
      {required this.name,
      required this.timeframe,
      required this.id,
      required this.status,
      this.createdAt});

  factory _$LocalesImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalesImplFromJson(json);

  @override
  final String name;
  @override
  final String timeframe;
  @override
  final String id;
  @override
  final String status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Locales(name: $name, timeframe: $timeframe, id: $id, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalesImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, timeframe, id, status, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalesImplCopyWith<_$LocalesImpl> get copyWith =>
      __$$LocalesImplCopyWithImpl<_$LocalesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalesImplToJson(
      this,
    );
  }
}

abstract class _Locales implements Locales {
  const factory _Locales(
      {required final String name,
      required final String timeframe,
      required final String id,
      required final String status,
      final DateTime? createdAt}) = _$LocalesImpl;

  factory _Locales.fromJson(Map<String, dynamic> json) = _$LocalesImpl.fromJson;

  @override
  String get name;
  @override
  String get timeframe;
  @override
  String get id;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$LocalesImplCopyWith<_$LocalesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
