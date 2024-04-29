import 'data/database/locale_remote_database.dart';
import 'data/repository_impl/locale_repository_impl.dart';
import 'domain/repositories/locale_repository.dart';
import 'domain/usecases/get.dart';
import 'domain/usecases/list.dart';
import 'presentation/bloc/locale_bloc.dart';
import 'package:get_it/get_it.dart';

void initLocale() {
  final sl = GetIt.instance;

  sl.registerFactory(() => LocaleBloc(listLocales: sl(), getLocale: sl()));

  sl.registerLazySingleton<LocaleRemoteDatabase>(
      () => LocaleRemoteDatabaseImpl());

  sl.registerLazySingleton<LocaleRepository>(
      () => LocaleRepositoryImpl(remoteDatabase: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => GetLocale(sl()));
  sl.registerLazySingleton(() => ListLocales(sl()));
}
