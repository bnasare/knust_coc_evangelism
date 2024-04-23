import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/create.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/get.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/list.dart';
import 'package:evangelism_admin/shared/error/failure.dart';
import 'package:evangelism_admin/shared/usecase/usecase.dart';

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

  Stream<Either<Failure, Prospect>> getAProspect(String documentID) async* {
    yield* getProspect(ObjectParams<String>(documentID));
  }

  Stream<Either<Failure, List<Prospect>>> listAllProspects(
      String documentID) async* {
    yield* listProspects(ObjectParams<List<String>>([documentID]));
  }
}
