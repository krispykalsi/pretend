import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/error.dart';
import 'package:core/network.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/data/models/subject_model.dart';
import 'package:pretend/data/repositories/subjects_repository.dart';

import 'subjects_repository_test.mocks.dart';

@GenerateMocks([
  SubjectsLocalDataSourceContract,
  SubjectsRemoteDataSourceContract,
  NetworkInfo,
])
void main() {
  late MockSubjectsLocalDataSourceContract mockLocalDataSource;
  late MockSubjectsRemoteDataSourceContract mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late SubjectsRepository repository;

  setUp(() {
    mockLocalDataSource = MockSubjectsLocalDataSourceContract();
    mockRemoteDataSource = MockSubjectsRemoteDataSourceContract();
    mockNetworkInfo = MockNetworkInfo();

    repository = SubjectsRepository(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tSubjectModelList = <SubjectModel>[
    const SubjectModel(name: "International Trade", code: "HU-351a"),
    const SubjectModel(name: "Computer Networks", code: "IT-502"),
    const SubjectModel(name: "Theory of Computing", code: "IT-504"),
  ];

  group(
    'when datasource is remote',
    () {
      final tDataSource = DataSource.NETWORK;
      final tCollegeID = "12321";

      test(
        'should check if device is online',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockLocalDataSource.getCollegeID())
              .thenAnswer((_) async => tCollegeID);
          when(mockRemoteDataSource.getSubjects(any))
              .thenAnswer((_) async => tSubjectModelList);

          await repository.getSubjects(tDataSource);

          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when call to remote datasource is successful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockLocalDataSource.getCollegeID())
              .thenAnswer((_) async => tCollegeID);
          when(mockRemoteDataSource.getSubjects(tCollegeID))
              .thenAnswer((_) async => tSubjectModelList);

          final result = await repository.getSubjects(tDataSource);

          verify(mockRemoteDataSource.getSubjects(tCollegeID));
          verify(mockLocalDataSource.getCollegeID());
          expect(result, equals(Right(tSubjectModelList)));
        },
      );

      test(
        'should return CollegeNotConfiguredFailure when college is not configured',
            () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockLocalDataSource.getCollegeID())
              .thenAnswer((_) async => null);

          final result = await repository.getSubjects(tDataSource);

          verify(mockLocalDataSource.getCollegeID());
          expect(result, equals(Left(CollegeNotConfiguredFailure())));
        },
      );

      test(
        'should return ServerFailure when call to remote datasource is unsuccessful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockLocalDataSource.getCollegeID())
              .thenAnswer((_) async => tCollegeID);
          when(mockRemoteDataSource.getSubjects(tCollegeID))
              .thenThrow(ServerException());

          final result = await repository.getSubjects(tDataSource);

          verify(mockRemoteDataSource.getSubjects(tCollegeID));
          verify(mockLocalDataSource.getCollegeID());
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
          when(mockLocalDataSource.getAllSubjects())
              .thenAnswer((_) async => tSubjectModelList);

          await repository.getSubjects(tDataSource);

          verifyZeroInteractions(mockNetworkInfo);
        },
      );

      group('GetAllSubjects', () {
        test(
          'should return local data when call to local datasource is successful',
          () async {
            when(mockLocalDataSource.getAllSubjects())
                .thenAnswer((_) async => tSubjectModelList);

            final result = await repository.getSubjects(tDataSource);

            verify(mockLocalDataSource.getAllSubjects());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Right(tSubjectModelList)));
          },
        );

        test(
          'should return NoLocalDataFailure when there is no local data present',
          () async {
            when(mockLocalDataSource.getAllSubjects())
                .thenThrow(NoLocalDataException());

            final result = await repository.getSubjects(tDataSource);

            verify(mockLocalDataSource.getAllSubjects());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(NoLocalDataFailure())));
          },
        );

        test(
          'should return CacheFailure when call to local datasource is unsuccessful',
          () async {
            when(mockLocalDataSource.getAllSubjects())
                .thenThrow(CacheException());

            final result = await repository.getSubjects(tDataSource);

            verify(mockLocalDataSource.getAllSubjects());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(CacheFailure())));
          },
        );
      });

      group('GetSubjects', () {
        final tSubjectKeys = ["HU-351a", "IT-502", "IT-504"];
        final tSubjectMap = {
          "HU-351a":
              const SubjectModel(name: "International Trade", code: "HU-351a"),
          "IT-502":
              const SubjectModel(name: "Computer Networks", code: "IT-502"),
          "IT-504":
              const SubjectModel(name: "Theory of Computing", code: "IT-504")
        };

        test(
          'should return local data when call to local datasource is successful',
          () async {
            when(mockLocalDataSource.getSubjects(tSubjectKeys))
                .thenAnswer((_) async => tSubjectMap);

            final result = await repository.getSubjectsFromKeys(tSubjectKeys);

            verify(mockLocalDataSource.getSubjects(tSubjectKeys));
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Right(tSubjectMap)));
          },
        );

        test(
          'should return CacheFailure when call to local datasource is unsuccessful',
          () async {
            when(mockLocalDataSource.getSubjects(tSubjectKeys))
                .thenThrow(CacheException());

            final result = await repository.getSubjectsFromKeys(tSubjectKeys);

            verify(mockLocalDataSource.getSubjects(tSubjectKeys));
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(CacheFailure())));
          },
        );
      });
    },
  );
}
