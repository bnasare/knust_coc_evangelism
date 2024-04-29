import 'package:dartz/dartz.dart';
import '../entities/prospect.dart';
import '../../../../shared/error/failure.dart';

abstract class ProspectRepository {
  Future<Either<Failure, Prospect>> createProspect(Prospect prospect);
  Stream<Either<Failure, Prospect>> getProspect(String documentID);
  Stream<Either<Failure, List<Prospect>>> listProspects(String localeID);
}
