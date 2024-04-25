import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/data/database/prospect_remote_database.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/shared/error/exception.dart';
import 'package:evangelism_admin/shared/platform/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/error/failure.dart';

class ProspectRepositoryImpl implements ProspectRepository {
  NetworkInfo networkInfo;
  ProspectRemoteDatabase remoteDatabase;

  ProspectRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, Prospect>> createProspect(Prospect prospect) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.createProspect(prospect);
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

  @override
  Stream<Either<Failure, Prospect>> getProspect(String documentID) {
    try {
      networkInfo.hasInternet();
      final results = remoteDatabase.getProspect(documentID);
      return results.map((prospect) => Right(prospect));
    } on FirebaseAuthException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again')));
    } on DeviceException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(error.message)));
    } on FirebaseException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again')));
    } catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(
          const Left(Failure('Something went wrong... Please try again')));
    }
  }

  @override
  Stream<Either<Failure, List<Prospect>>> listProspects(
      List<String> documentID) {
    try {
      networkInfo.hasInternet();
      final results = remoteDatabase.listProspects(documentID);
      return results.map((prospects) => Right(prospects));
    } on FirebaseAuthException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again')));
    } on DeviceException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(error.message)));
    } on FirebaseException catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again')));
    } catch (error) {
      // Return a Left value with the appropriate Failure object
      return Stream.value(
          const Left(Failure('Something went wrong... Please try again')));
    }
  }
}
