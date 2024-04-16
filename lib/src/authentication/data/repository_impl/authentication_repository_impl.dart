import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/leader/domain/entities/leader.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/error/exception.dart';
import '../../../../shared/error/failure.dart';
import '../../../../shared/platform/network_info.dart';
import '../../domain/repository/authentication_repository.dart';
import '../database/authentication_remote_database.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  NetworkInfo networkInfo;
  AuthenticationRemoteDatabase remoteDatabase;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, Leader>> logout() async {
    try {
      await networkInfo.hasInternet();
      await remoteDatabase.logout();
      return Right(Leader.initial());
    } on FirebaseAuthException catch (error) {
      return Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    } on FirebaseException catch (error) {
      return Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } catch (error) {
      return const Left(Failure('Something went wrong... Please try again'));
    }
  }

  @override
  Future<Either<Failure, Leader>> login(String email, String password) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.login(email, password);
      return Right(results);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    } on FirebaseException catch (error) {
      return Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } catch (error) {
      return const Left(Failure('Something went wrong... Please try again'));
    }
  }
}
