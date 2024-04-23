import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/create.dart';
import 'package:evangelism_admin/shared/error/failure.dart';

import '../../domain/entities/prospect.dart';

class ProspectBloc {
  CreateProspect createProspect;

  ProspectBloc({required this.createProspect});

  Future<Either<Failure, Prospect>> createAProspect(Prospect prospect) async {
    return await createProspect(CreateProspectParams(prospect: prospect));
  }
}
