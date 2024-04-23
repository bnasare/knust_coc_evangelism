import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

import '../entities/prospect.dart';
import '../repositories/prospect_repository.dart';

class CreateProspect implements UseCase<Prospect, CreateProspectParams> {
  final ProspectRepository repository;

  CreateProspect(this.repository);

  @override
  Future<Either<Failure, Prospect>> call(CreateProspectParams params) {
    return repository.createProspect(params.prospect);
  }
}

class CreateProspectParams extends ObjectParams<Prospect> {
  final Prospect prospect;

  const CreateProspectParams({required this.prospect}) : super(prospect);

  String get initialContact => prospect.initialContact;
  String get evangelismSetting => prospect.evangelismSetting;
  String get name => prospect.name;
  String get mobile => prospect.mobile;
  String get demographics => prospect.demographics;
  String get gender => prospect.gender;
  String get religiousAffiliation => prospect.religiousAffiliation;
  String get baptismalStatus => prospect.baptismalStatus;
  String get interactionDetails => prospect.interactionDetails;
  String get id => prospect.id;
  DateTime? get createdAt => prospect.createdAt;
}
