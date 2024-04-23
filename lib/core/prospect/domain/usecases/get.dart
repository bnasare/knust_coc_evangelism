import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

class GetProspect implements StreamUseCase<Prospect, GetProspectParams> {
  final ProspectRepository repository;

  GetProspect(this.repository);

  @override
  Stream<Either<Failure, Prospect>> call(GetProspectParams params) {
    return repository.getProspect(params.documentID);
  }
}

class GetProspectParams extends ObjectParams<String> {
  const GetProspectParams({required String documentID}) : super(documentID);

  String get documentID => value;
}
