import 'package:evangelism_admin/core/prospect/data/database/prospect_remote_database.dart';
import 'package:evangelism_admin/core/prospect/data/repository_impl/prospect_repository_impl.dart';
import 'package:evangelism_admin/core/prospect/domain/repositories/prospect_repository.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/create.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/get.dart';
import 'package:evangelism_admin/core/prospect/domain/usecases/list.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_bloc.dart';
import 'package:get_it/get_it.dart';

void initProspect() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<ProspectRemoteDatabase>(
      () => ProspectRemoteDatabaseImpl());
  sl.registerLazySingleton<ProspectRepository>(
      () => ProspectRepositoryImpl(networkInfo: sl(), remoteDatabase: sl()));

  sl.registerFactory(() => ProspectBloc(
      createProspect: sl(), getProspect: sl(), listProspects: sl()));

  sl.registerLazySingleton(() => CreateProspect(sl()));
  sl.registerLazySingleton(() => GetProspect(sl()));
  sl.registerLazySingleton(() => ListProspects(sl()));
}
