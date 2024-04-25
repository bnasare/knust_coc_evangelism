import 'package:freezed_annotation/freezed_annotation.dart';

part 'locales.freezed.dart';
part 'locales.g.dart';

@freezed
class Locales with _$Locales {
  const factory Locales({
    required String name,
    required String timeframe,
    required String id,
    required String status,
    final DateTime? createdAt,
  }) = _Locales;

  factory Locales.fromJson(Map<String, dynamic> json) =>
      _$LocalesFromJson(json);

  factory Locales.initial() => const Locales(
        name: '',
        timeframe: '',
        id: '',
        status: '',
        createdAt: null,
      );
}
