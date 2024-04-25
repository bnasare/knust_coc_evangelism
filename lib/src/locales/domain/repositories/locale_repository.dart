import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/failure.dart';

import '../entities/locales.dart';

abstract class LocaleRepository {
  Stream<Either<Failure, Locales>> getLocale(String documentID);
  Stream<Either<Failure, List<Locales>>> listLocales();
}
