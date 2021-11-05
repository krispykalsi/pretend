import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/application/bloc/setup/timetable/timetable_setup_bloc.dart';
import 'package:pretend/core/network/network_info.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/data/repositories/subjects_repository.dart';
import 'package:pretend/data/repositories/timetable_repository.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';
import 'package:pretend/domain/usecases/set_timetable.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  sl.registerFactory(
    () => SubjectsBloc(getAllSubjects: sl()),
  );

  sl.registerFactory(
    () => TimetableSetupBloc(setTimetable: sl()),
  );

  sl.registerLazySingleton(() => GetAllSubjects(sl()));
  sl.registerLazySingleton(() => SetTimetable(sl()));

  sl.registerLazySingleton<SubjectsRepositoryContract>(
    () => SubjectsRepository(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<TimetableRepositoryContract>(
    () => TimetableRepository(sl()),
  );

  sl.registerLazySingleton<SubjectsLocalDataSourceContract>(
      () => SubjectsLocalDataSource(hive: Hive));
  sl.registerLazySingleton<SubjectsRemoteDataSourceContract>(
      () => SubjectsRemoteDataSource());
  sl.registerLazySingleton<TimetableLocalDataSourceContract>(
    () => TimetableLocalDataSource(hive: Hive),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
