import 'package:freezed_annotation/freezed_annotation.dart';

part 'leader.freezed.dart';
part 'leader.g.dart';

@freezed
class Leader with _$Leader {
  const factory Leader({
    required String name,
    required String email,
    required String id,
  }) = _Leader;

  factory Leader.fromJson(Map<String, dynamic> json) => _$LeaderFromJson(json);

  factory Leader.initial() => const Leader(
        name: '',
        email: '',
        id: '',
      );
}
