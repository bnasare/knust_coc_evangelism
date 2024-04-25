import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

class GetProspect implements StreamUseCase<Prospect, ObjectParams<String>> {
  final ProspectRepository repository;

  GetProspect(this.repository);

  @override
  Stream<Either<Failure, Prospect>> call(ObjectParams<String> params)  {
    return repository.getProspect(params.value);
  }
}
