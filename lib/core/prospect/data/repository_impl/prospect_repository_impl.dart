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
  Stream<Either<Failure, Prospect>> getProspect(String documentID) async* {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.getProspect(documentID).first;
      yield Right(results);
    } on FirebaseAuthException catch (error) {
      yield Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } on DeviceException catch (error) {
      yield Left(Failure(error.message));
    } on FirebaseException catch (error) {
      yield Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } catch (error) {
      yield const Left(Failure('Something went wrong... Please try again'));
    }
  }

  @override
  Stream<Either<Failure, List<Prospect>>> listProspects(
      List<String> documentID) async* {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.listProspects(documentID).first;
      yield Right(results);
    } on FirebaseAuthException catch (error) {
      yield Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } on DeviceException catch (error) {
      yield Left(Failure(error.message));
    } on FirebaseException catch (error) {
      yield Left(Failure(
          error.message ?? 'Unexpected error occurred... Please try again'));
    } catch (error) {
      yield const Left(Failure('Something went wrong... Please try again'));
    }
  }
}
