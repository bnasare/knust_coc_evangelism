import 'package:freezed_annotation/freezed_annotation.dart';

part 'prospect.freezed.dart';
part 'prospect.g.dart';

@freezed
class Prospect with _$Prospect {
  const factory Prospect({
    required String evangelismSetting,
    required String initialContact,
    required String name,
    required String mobile,
    required String demographics,
    required String gender,
    required String religiousAffiliation,
    required String baptismalStatus,
    required String interactionDetails,
    required String id,
    String? localeID,
    final DateTime? createdAt,
  }) = _Prospect;

  factory Prospect.fromJson(Map<String, dynamic> json) =>
      _$ProspectFromJson(json);

  factory Prospect.initial() => const Prospect(
        evangelismSetting: '',
        initialContact: '',
        name: '',
        mobile: '',
        demographics: '',
        gender: '',
        religiousAffiliation: '',
        baptismalStatus: '',
        interactionDetails: '',
        id: '',
        localeID: '',
        createdAt: null,
      );
}
