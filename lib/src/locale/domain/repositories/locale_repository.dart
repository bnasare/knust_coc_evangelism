import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/failure.dart';

import '../entities/locale.dart';

abstract class LocaleRepository {
  Stream<Either<Failure, Locale>> getLocale(String documentID);
  Stream<Either<Failure, List<Locale>>> listLocales();
}
