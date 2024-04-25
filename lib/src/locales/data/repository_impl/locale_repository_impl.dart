import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/exception.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/platform/network_info.dart';
import 'package:evangelism_admin/src/locales/data/database/locale_remote_database.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/domain/repositories/locale_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  NetworkInfo networkInfo;
  LocaleRemoteDatabase remoteDatabase;

  LocaleRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });

  @override
  Stream<Either<Failure, List<Locales>>> listLocales() {
    try {
      networkInfo.hasInternet();
      final results = remoteDatabase.listLocales();
      // Wrap the results in a Right value and return
      return results.map((locales) => Right(locales));
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
  Stream<Either<Failure, Locales>> getLocale(String documentID) {
    try {
      networkInfo.hasInternet();
      final results = remoteDatabase.getLocale(documentID);
      return results.map((locale) => Right(locale));
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
