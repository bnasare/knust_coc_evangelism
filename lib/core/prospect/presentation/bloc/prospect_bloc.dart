import 'package:dartz/dartz.dart';
import '../../domain/usecases/create.dart';
import '../../domain/usecases/get.dart';
import '../../domain/usecases/list.dart';
import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';

import '../../domain/entities/prospect.dart';

class ProspectBloc {
  CreateProspect createProspect;
  GetProspect getProspect;
  ListProspects listProspects;

  ProspectBloc(
      {required this.createProspect,
      required this.getProspect,
      required this.listProspects});

  Future<Either<Failure, Prospect>> createAProspect(Prospect prospect) async {
    return await createProspect(CreateProspectParams(prospect: prospect));
  }

  Stream<Either<Failure, Prospect>> getAProspect(String documentID) {
    return getProspect(ObjectParams<String>(documentID));
  }

  Stream<Either<Failure, List<Prospect>>> listAllProspects(
      String documentID)  {
    return listProspects(ObjectParams<String>(documentID));
  }
}
