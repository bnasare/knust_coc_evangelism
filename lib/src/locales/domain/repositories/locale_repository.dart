import 'package:dartz/dartz.dart';
import '../../../../shared/error/failure.dart';

import '../entities/locales.dart';

abstract class LocaleRepository {
  Stream<Either<Failure, Locales>> getLocale();
  Stream<Either<Failure, List<Locales>>> listLocales();
}
