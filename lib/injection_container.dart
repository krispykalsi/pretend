import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/core/network/network_info.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/data/repositories/subjects_repository.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => SubjectsBloc(getAllSubjects: sl()),
  );

  sl.registerLazySingleton(() => GetAllSubjects(sl()));
  sl.registerLazySingleton<SubjectsRepositoryContract>(
    () => SubjectsRepository(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SubjectsLocalDataSourceContract>(
      () => SubjectsLocalDataSource(hive: Hive));
  sl.registerLazySingleton<SubjectsRemoteDataSourceContract>(
      () => SubjectsRemoteDataSource());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
