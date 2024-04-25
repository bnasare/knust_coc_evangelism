import 'package:dartz/dartz.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/shared/error/failure.dart';

abstract class ProspectRepository {
  Future<Either<Failure, Prospect>> createProspect(Prospect prospect);
  Stream<Either<Failure, Prospect>> getProspect(String documentID);
  Stream<Either<Failure, List<Prospect>>> listProspects(String localeID);
}
