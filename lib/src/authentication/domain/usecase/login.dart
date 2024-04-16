import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:evangelism_admin/core/leader/domain/entities/leader.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../repository/authentication_repository.dart';

class Login implements UseCase<Leader, LoginParams> {
  final AuthenticationRepository repository;
  Login(this.repository);
  @override
  Future<Either<Failure, Leader>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
