import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/exception.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/platform/network_info.dart';
import 'package:evangelism_admin/src/locale/data/database/locale_remote_database.dart';
import 'package:evangelism_admin/src/locale/domain/entities/locale.dart';
import 'package:evangelism_admin/src/locale/domain/repositories/locale_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  NetworkInfo networkInfo;
  LocaleRemoteDatabase remoteDatabase;

  LocaleRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });

  @override
  Stream<Either<Failure, List<Locale>>> listLocales() async* {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.listLocales().first;
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
  Stream<Either<Failure, Locale>> getLocale(String documentID) async* {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.getLocale(documentID).first;
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
