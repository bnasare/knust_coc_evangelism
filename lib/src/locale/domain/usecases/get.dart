import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

import '../../../../shared/error/failure.dart';
import '../entities/locale.dart';
import '../repositories/locale_repository.dart';

class GetLocale implements StreamUseCase<Locale, ObjectParams<String>> {
  final LocaleRepository repository;

  GetLocale(this.repository);

  @override
  Stream<Either<Failure, Locale>> call(ObjectParams<String> params) async* {
    yield* repository.getLocale(params.value);
  }
}
