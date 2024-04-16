import 'package:get_it/get_it.dart';

import 'data/database/authentication_remote_database.dart';
import 'data/repository_impl/authentication_repository_impl.dart';
import 'domain/repository/authentication_repository.dart';
import 'domain/usecase/login.dart';
import 'domain/usecase/logout.dart';
import 'presentation/bloc/auth_bloc.dart';

void initAuth() {
  final sl = GetIt.instance;

  sl.registerFactory(() => AuthBloc(login: sl(), logout: sl()));

  sl.registerLazySingleton<AuthenticationRemoteDatabase>(
      () => AuthenticationRemoteDatabaseImpl());

  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(networkInfo: sl(), remoteDatabase: sl()));

  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => Login(sl()));
}
