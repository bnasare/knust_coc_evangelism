import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

class ListProspects
    implements StreamUseCase<List<Prospect>, ObjectParams<List<String>>> {
  final ProspectRepository repository;

  ListProspects(this.repository);

  @override
  Stream<Either<Failure, List<Prospect>>> call(
      ObjectParams<List<String>> params) async* {
    yield* repository.listProspects(params.value);
  }
}
