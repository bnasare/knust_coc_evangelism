import 'package:dartz/dartz.dart';
import '../../../../shared/error/exception.dart';
import '../../../../shared/error/failure.dart';
import '../../../../shared/platform/network_info.dart';
import '../database/locale_remote_database.dart';
import '../../domain/entities/locales.dart';
import '../../domain/repositories/locale_repository.dart';
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
  Stream<Either<Failure, Locales>> getLocale() {
    try {
      networkInfo.hasInternet();
      final results = remoteDatabase.getLocale();
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
