import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/core/network/network_info.dart';
import 'package:pretend/features/timetable/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/features/timetable/data/data_sources/timetable_remote_datasource.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';
import 'package:pretend/features/timetable/data/repositories/timetable_repository_implementation.dart';

import 'timetable_repository_implementation_test.mocks.dart';

@GenerateMocks([
  TimetableLocalDataSource,
  TimetableRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockTimetableLocalDataSource mockLocalDataSource;
  late MockTimetableRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TimetableRepositoryImplementation repository;

  setUp(() {
    mockLocalDataSource = MockTimetableLocalDataSource();
    mockRemoteDataSource = MockTimetableRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = TimetableRepositoryImplementation(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tSubjectModelList = <SubjectModel>[
    SubjectModel(name: "International Trade", code: "HU-351a"),
    SubjectModel(name: "Computer Networks", code: "IT-502"),
    SubjectModel(name: "Theory of Computing", code: "IT-504"),
  ];

  group(
    'when datasource is remote',
    () {
      late DataSource tDataSource;

      setUp(() {
        tDataSource = DataSource.NETWORK;
      });

      test(
        'should check if device is online',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getSubjects())
              .thenAnswer((_) async => tSubjectModelList);

          await repository.getSubjects(tDataSource);

          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when call to remote datasource is successful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getSubjects())
              .thenAnswer((_) async => tSubjectModelList);

          final result = await repository.getSubjects(tDataSource);

          verify(mockRemoteDataSource.getSubjects());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Right(tSubjectModelList)));
        },
      );

      test(
        'should return ServerFailure when call to remote datasource is unsuccessful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getSubjects()).thenThrow(ServerException());

          final result = await repository.getSubjects(tDataSource);

          verify(mockRemoteDataSource.getSubjects());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return NoInternetFailure when device is offline',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

          final result = await repository.getSubjects(tDataSource);

          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(NoInternetFailure())));
        },
      );
    },
  );

  group(
    'when data source is local',
    () {
      late DataSource tDataSource;

      setUp(() {
        tDataSource = DataSource.LOCAL;
      });

      test(
        'should not check device network info',
        () async {
          when(mockLocalDataSource.getSubjects())
              .thenAnswer((_) async => tSubjectModelList);

          await repository.getSubjects(tDataSource);

          verifyZeroInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return local data when call to local datasource is successful',
        () async {
          when(mockLocalDataSource.getSubjects())
              .thenAnswer((_) async => tSubjectModelList);

          final result = await repository.getSubjects(tDataSource);

          verify(mockLocalDataSource.getSubjects());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Right(tSubjectModelList)));
        },
      );

      test(
        'should return NoLocalDataFailure when there is no local data present',
        () async {
          when(mockLocalDataSource.getSubjects())
              .thenThrow(NoLocalDataException());

          final result = await repository.getSubjects(tDataSource);

          verify(mockLocalDataSource.getSubjects());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(NoLocalDataFailure())));
        },
      );

      test(
        'should return CacheFailure when call to local datasource is unsuccessful',
            () async {
          when(mockLocalDataSource.getSubjects())
              .thenThrow(CacheException());

          final result = await repository.getSubjects(tDataSource);

          verify(mockLocalDataSource.getSubjects());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );
}
