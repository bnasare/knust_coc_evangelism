import 'package:dartz/dartz.dart';
import '../entities/prospect.dart';
import '../repositories/prospect_repository.dart';
import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';

class ListProspects
    implements StreamUseCase<List<Prospect>, ObjectParams<String>> {
  final ProspectRepository repository;

  ListProspects(this.repository);

  @override
  Stream<Either<Failure, List<Prospect>>> call(
      ObjectParams<String> params){
    return repository.listProspects(params.value);
  }
}
