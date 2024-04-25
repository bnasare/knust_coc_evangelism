import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

import '../../../../shared/error/failure.dart';
import '../entities/locales.dart';
import '../repositories/locale_repository.dart';

class GetLocale implements StreamUseCase<Locales, ObjectParams<String>> {
  final LocaleRepository repository;

  GetLocale(this.repository);

  @override
  Stream<Either<Failure, Locales>> call(ObjectParams<String> params) {
    return repository.getLocale(params.value);
  }
}
