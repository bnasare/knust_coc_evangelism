import 'data/database/prospect_remote_database.dart';
import 'data/repository_impl/prospect_repository_impl.dart';
import 'domain/repositories/prospect_repository.dart';
import 'domain/usecases/create.dart';
import 'domain/usecases/get.dart';
import 'domain/usecases/list.dart';
import 'presentation/bloc/prospect_bloc.dart';
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
