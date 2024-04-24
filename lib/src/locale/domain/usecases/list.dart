import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';
import 'package:evangelism_admin/src/locale/domain/entities/locale.dart';
import 'package:evangelism_admin/src/locale/domain/repositories/locale_repository.dart';

import '../../../../shared/error/failure.dart';

class ListLocales implements StreamUseCase<List<Locale>, NoParams> {
  final LocaleRepository repository;

  ListLocales(this.repository);

  @override
  Stream<Either<Failure, List<Locale>>> call(NoParams params) async* {
    yield* repository.listLocales();
  }
}
