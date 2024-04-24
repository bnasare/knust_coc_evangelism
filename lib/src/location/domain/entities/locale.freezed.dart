// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Locale _$LocaleFromJson(Map<String, dynamic> json) {
  return _Locale.fromJson(json);
}

/// @nodoc
mixin _$Locale {
  String get name => throw _privateConstructorUsedError;
  String get timeframe => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocaleCopyWith<Locale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocaleCopyWith<$Res> {
  factory $LocaleCopyWith(Locale value, $Res Function(Locale) then) =
      _$LocaleCopyWithImpl<$Res, Locale>;
  @useResult
  $Res call({String name, String timeframe, String id});
}

/// @nodoc
class _$LocaleCopyWithImpl<$Res, $Val extends Locale>
    implements $LocaleCopyWith<$Res> {
  _$LocaleCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocaleImplCopyWith<$Res> implements $LocaleCopyWith<$Res> {
  factory _$$LocaleImplCopyWith(
          _$LocaleImpl value, $Res Function(_$LocaleImpl) then) =
      __$$LocaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String timeframe, String id});
}

/// @nodoc
class __$$LocaleImplCopyWithImpl<$Res>
    extends _$LocaleCopyWithImpl<$Res, _$LocaleImpl>
    implements _$$LocaleImplCopyWith<$Res> {
  __$$LocaleImplCopyWithImpl(
      _$LocaleImpl _value, $Res Function(_$LocaleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? timeframe = null,
    Object? id = null,
  }) {
    return _then(_$LocaleImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocaleImpl implements _Locale {
  const _$LocaleImpl(
      {required this.name, required this.timeframe, required this.id});

  factory _$LocaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocaleImplFromJson(json);

  @override
  final String name;
  @override
  final String timeframe;
  @override
  final String id;

  @override
  String toString() {
    return 'Locale(name: $name, timeframe: $timeframe, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocaleImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, timeframe, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocaleImplCopyWith<_$LocaleImpl> get copyWith =>
      __$$LocaleImplCopyWithImpl<_$LocaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocaleImplToJson(
      this,
    );
  }
}

abstract class _Locale implements Locale {
  const factory _Locale(
      {required final String name,
      required final String timeframe,
      required final String id}) = _$LocaleImpl;

  factory _Locale.fromJson(Map<String, dynamic> json) = _$LocaleImpl.fromJson;

  @override
  String get name;
  @override
  String get timeframe;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$LocaleImplCopyWith<_$LocaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
