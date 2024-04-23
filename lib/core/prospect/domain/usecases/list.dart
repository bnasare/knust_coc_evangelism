import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

class ListProspects
    implements StreamUseCase<List<Prospect>, ListProspectsParams> {
  final ProspectRepository repository;

  ListProspects(this.repository);

  @override
  Stream<Either<Failure, List<Prospect>>> call(ListProspectsParams params) {
    return repository.listProspects(params.documentID);
  }
}

class ListProspectsParams extends ObjectParams<List<String>> {
  const ListProspectsParams({required List<String> documentID})
      : super(documentID);

  List<String> get documentID => value;
}
