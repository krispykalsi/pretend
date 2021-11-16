import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/fetch_subjects_online/fetch_subjects_online_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/new_subject/new_subject_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/application/bloc/setup/timetable/timetable_setup_bloc.dart';
import 'package:core/network.dart';
import 'package:pretend/data/data_sources/settings_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/data/repositories/settings_repository.dart';
import 'package:pretend/data/repositories/subjects_repository.dart';
import 'package:pretend/data/repositories/timetable_repository.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/add_subject.dart';
import 'package:pretend/domain/usecases/generate_schedule_for_today.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';
import 'package:pretend/domain/usecases/get_app_settings.dart';
import 'package:pretend/domain/usecases/get_subjects_of_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';
import 'package:pretend/domain/usecases/mark_app_visited_first_time.dart';
import 'package:pretend/domain/usecases/set_app_theme_color.dart';
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
  sl.registerFactory(
    () => HomeBloc(generateScheduleForToday: sl()),
  );
  sl.registerFactory(
    () => NewSubjectBloc(sl()),
  );
  sl.registerFactory(
    () => FetchSubjectsOnlineBloc(getAllSubjects: sl()),
  );
  sl.registerFactory(
    () => SettingsBloc(
      getAppSettings: sl(),
      markAppVisitedFirstTime: sl(),
      setAppThemeColor: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllSubjects(sl()));
  sl.registerLazySingleton(() => GetTimetable(sl()));
  sl.registerLazySingleton(() => SetTimetable(sl()));
  sl.registerLazySingleton(() => GetSubjectsOfTimetable(sl()));
  sl.registerLazySingleton(() => GenerateScheduleForToday(sl(), sl()));
  sl.registerLazySingleton(() => AddSubject(sl()));
  sl.registerLazySingleton(() => GetAppSettings(sl()));
  sl.registerLazySingleton(() => MarkAppVisitedFirstTime(sl()));
  sl.registerLazySingleton(() => SetAppThemeColor(sl()));

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
  sl.registerLazySingleton<SettingsRepositoryContract>(
    () => SettingsRepository(sl()),
  );

  sl.registerLazySingleton<SubjectsLocalDataSourceContract>(
      () => SubjectsLocalDataSource(hive: Hive));
  sl.registerLazySingleton<SubjectsRemoteDataSourceContract>(
      () => SubjectsRemoteDataSource());
  sl.registerLazySingleton<TimetableLocalDataSourceContract>(
      () => TimetableLocalDataSource(hive: Hive));
  sl.registerLazySingleton<SettingsLocalDatasourceContract>(
      () => SettingsLocalDatasource(Hive));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}