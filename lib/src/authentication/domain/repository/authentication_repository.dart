import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/leader/domain/entities/leader.dart';

import '../../../../shared/error/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Leader>> logout();
  Future<Either<Failure, Leader>> login(String email, String password);
}
