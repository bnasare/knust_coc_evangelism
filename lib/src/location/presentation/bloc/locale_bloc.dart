import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';
import 'package:evangelism_admin/src/location/domain/entities/locale.dart';
import 'package:evangelism_admin/src/location/domain/usecases/get.dart';
import 'package:evangelism_admin/src/location/domain/usecases/list.dart';

class LocaleBloc {
  GetLocale getLocale;
  ListLocales listLocales;

  LocaleBloc({required this.getLocale, required this.listLocales});

  Stream<Either<Failure, Locale>> getALocale(String documentID) async* {
    yield* getLocale(ObjectParams<String>(documentID));
  }

  Stream<Either<Failure, List<Locale>>> listAllLocales() async* {
    yield* listLocales(NoParams());
  }
}
