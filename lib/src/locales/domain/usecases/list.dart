import 'package:dartz/dartz.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/locales.dart';
import '../repositories/locale_repository.dart';

import '../../../../shared/error/failure.dart';

class ListLocales implements StreamUseCase<List<Locales>, NoParams> {
  final LocaleRepository repository;

  ListLocales(this.repository);

  @override
  Stream<Either<Failure, List<Locales>>> call(NoParams params)  {
    return repository.listLocales();
  }
}
