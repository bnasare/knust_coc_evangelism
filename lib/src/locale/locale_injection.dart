import 'package:evangelism_admin/src/locale/data/database/locale_remote_database.dart';
import 'package:evangelism_admin/src/locale/data/repository_impl/locale_repository_impl.dart';
import 'package:evangelism_admin/src/locale/domain/repositories/locale_repository.dart';
import 'package:evangelism_admin/src/locale/domain/usecases/get.dart';
import 'package:evangelism_admin/src/locale/domain/usecases/list.dart';
import 'package:evangelism_admin/src/locale/presentation/bloc/locale_bloc.dart';
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
