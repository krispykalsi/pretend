import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/features/timetable/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/features/timetable/data/repositories/timetable_repository.dart';
import 'package:pretend/features/timetable/domain/entities/class_category_enum.dart';
import 'package:pretend/features/timetable/domain/entities/days_enum.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';
import 'package:pretend/features/timetable/domain/entities/time_set_enum.dart';

import 'timetable_repository_test.mocks.dart';

@GenerateMocks([TimetableLocalDataSourceContract])
void main() {
  late MockTimetableLocalDataSourceContract mockLocalDataSource;
  late TimetableRepository repository;

  setUp(() {
    mockLocalDataSource = MockTimetableLocalDataSourceContract();
    repository = TimetableRepository(mockLocalDataSource);
  });

  final tTimetable = {
    Days.FRIDAY: {
      TimeSets.T8AM: TimeSet(
        start: "8 AM",
        end: "10 AM",
        duration: 2,
        classCategory: ClassCategories.THEORY,
        subjectKey: "dsfFSFS3",
      ),
      TimeSets.T9AM: TimeSet(
        start: "8 AM",
        end: "10 AM",
        duration: 2,
        classCategory: ClassCategories.THEORY,
        subjectKey: "dsfFSFS3",
      ),
      TimeSets.T1PM: TimeSet(
        start: "1 PM",
        end: "2 PM",
        duration: 1,
        classCategory: ClassCategories.LAB,
        subjectKey: "fdsdfEv",
      ),
      TimeSets.T11AM: TimeSet(
        start: "11 AM",
        end: "12 PM",
        duration: 1,
        classCategory: ClassCategories.THEORY,
        subjectKey: "FHVBVsf356",
      ),
    }
  };

  group('get Timetable', () {
    test(
      'should return local data when call to local datasource is successful',
          () async {
        when(mockLocalDataSource.getTimetable())
            .thenAnswer((_) async => tTimetable);
        final result = await repository.getTimetable();
        verify(mockLocalDataSource.getTimetable());
        expect(result, equals(Right(tTimetable)));
      },
    );

    test(
      'should return CacheFailure when call to local datasource is unsuccessful',
          () async {
        when(mockLocalDataSource.getTimetable())
            .thenThrow(CacheException());
        final result = await repository.getTimetable();
        verify(mockLocalDataSource.getTimetable());
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });

  group('set Timetable', () {
    test(
      'should set Timetable when call to local datasource is successful',
          () async {
        when(mockLocalDataSource.setTimetable(tTimetable))
            .thenAnswer((_) async => Right(null));
        final result = await repository.setTimetable(tTimetable);
        verify(mockLocalDataSource.setTimetable(tTimetable));
        expect(result, equals(Right(null)));
      },
    );

    test(
      'should return CacheFailure when call to local datasource is unsuccessful',
          () async {
        when(mockLocalDataSource.setTimetable(tTimetable))
            .thenThrow(CacheException());
        final result = await repository.setTimetable(tTimetable);
        verify(mockLocalDataSource.setTimetable(tTimetable));
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });
}