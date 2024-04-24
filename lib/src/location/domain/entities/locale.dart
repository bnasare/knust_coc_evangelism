import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale.freezed.dart';
part 'locale.g.dart';

@freezed
class Locale with _$Locale {
  const factory Locale({
    required String name,
    required String timeframe,
    required String id,
  }) = _Locale;

  factory Locale.fromJson(Map<String, dynamic> json) => _$LocaleFromJson(json);

  factory Locale.initial() => const Locale(
        name: '',
        timeframe: '',
        id: '',
      );
}
