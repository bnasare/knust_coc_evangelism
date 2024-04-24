import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/domain/usecases/get.dart';
import 'package:evangelism_admin/src/locales/domain/usecases/list.dart';

class LocaleBloc {
  GetLocale getLocale;
  ListLocales listLocales;

  LocaleBloc({required this.getLocale, required this.listLocales});

  Stream<Either<Failure, Locales>> getALocale(String documentID) async* {
    yield* getLocale(ObjectParams<String>(documentID));
  }

  Future<Either<Failure, List<Locales>>> listAllLocales() async {
    return listLocales(NoParams());
  }
}
