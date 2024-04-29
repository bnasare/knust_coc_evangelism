import 'package:dartz/dartz.dart';
import '../../../../shared/usecase/usecase.dart';

import '../../../../shared/error/failure.dart';
import '../entities/locales.dart';
import '../repositories/locale_repository.dart';

class GetLocale implements StreamUseCase<Locales, NoParams> {
  final LocaleRepository repository;

  GetLocale(this.repository);

  @override
  Stream<Either<Failure, Locales>> call(NoParams params) {
    return repository.getLocale();
  }
}
