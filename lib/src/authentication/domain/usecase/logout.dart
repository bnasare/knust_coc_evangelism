import 'package:dartz/dartz.dart';
import '../../../../core/leader/domain/entities/leader.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../repository/authentication_repository.dart';

class Logout implements UseCase<Leader, NoParams> {
  AuthenticationRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, Leader>> call(NoParams params) {
    return repository.logout();
  }
}
