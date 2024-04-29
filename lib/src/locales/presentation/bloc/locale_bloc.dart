import 'package:dartz/dartz.dart';
import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../../domain/entities/locales.dart';
import '../../domain/usecases/get.dart';
import '../../domain/usecases/list.dart';

class LocaleBloc {
  GetLocale getLocale;
  ListLocales listLocales;

  LocaleBloc({required this.getLocale, required this.listLocales});

  Stream<Either<Failure, Locales>> getALocale() {
    return getLocale(NoParams());
  }

  Stream<Either<Failure, List<Locales>>> listAllLocales() {
    return listLocales(NoParams());
  }
}
