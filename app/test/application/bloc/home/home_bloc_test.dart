import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/usecases/export_timetable.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

import '../../../fixtures/filtered_schedule.dart';
import '../../../fixtures/timetable.dart';
import '../../../fixtures/timetable_subjects.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetTimetableWithSubjects, FilterTimetable, ExportTimetable])
void main() {
  late MockGetTimetableWithSubjects mockGenerateScheduleForToday;
  late MockFilterTimetable mockFilterTimetable;
  late MockExportTimetable mockExportTimetable;
  late HomeBloc bloc;

  setUp(() {
    mockGenerateScheduleForToday = MockGetTimetableWithSubjects();
    mockFilterTimetable = MockFilterTimetable();
    mockExportTimetable = MockExportTimetable();
    bloc = HomeBloc(
      getTimetableWithSubjects: mockGenerateScheduleForToday,
      filterTimetable: mockFilterTimetable,
      exportTimetable: mockExportTimetable,
    );
  });

  final tTimetable = getTestTimetable;
  final tSubjects = getTestSubjectsOfTimetable;
  final tFilteredSchedule = getTestFilteredSchedule;

  final timetableWithSubjectsOutput = TimetableWithSubjects(
    tTimetable,
    tSubjects,
  );

  final tDateTime = DateFormat("H:mm").parse("11:05");
  final tParams = FilterTimetableParams(tDateTime, tTimetable);

  test(
    'should call usecases with correct parameters',
    () async {
      when(mockGenerateScheduleForToday(any))
          .thenAnswer((_) async => Right(timetableWithSubjectsOutput));
      when(mockFilterTimetable(any))
          .thenAnswer((_) async => Right(tFilteredSchedule));
      bloc.add(GetTimetableEvent(tDateTime));
      await untilCalled(mockGenerateScheduleForToday(any));
      await untilCalled(mockFilterTimetable(any));
      verify(mockGenerateScheduleForToday(NoParams()));
      verify(mockFilterTimetable(tParams));
    },
  );

  test(
    'should emit [Loading, Loaded] when data is gotten successfully',
    () {
      when(mockGenerateScheduleForToday(any))
          .thenAnswer((_) async => Right(timetableWithSubjectsOutput));
      when(mockFilterTimetable(any))
          .thenAnswer((_) async => Right(tFilteredSchedule));
      final expectedOrder = [
        const TimetableLoading(),
        TimetableLoaded(tTimetable, tSubjects, tFilteredSchedule),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedOrder));
      bloc.add(GetTimetableEvent(tDateTime));
    },
  );

  group(
    'should emit [Loading, Error] when data is NOT gotten successfully',
    () {
      test(
        'on CacheFailure',
        () async {
          final cacheFailure = CacheFailure();
          when(mockGenerateScheduleForToday(any))
              .thenAnswer((_) async => Left(cacheFailure));
          final expectedOrder = [
            const TimetableLoading(),
            TimetableError(cacheFailure.message),
          ];
          expectLater(bloc.stream, emitsInOrder(expectedOrder));
          bloc.add(GetTimetableEvent(tDateTime));
          await untilCalled(mockGenerateScheduleForToday(NoParams()));
          verify(mockGenerateScheduleForToday(NoParams()));
        },
      );

      test(
        'on FilterTimetableFailure',
        () async {
          const tMsg = "xyz error";
          final filterTimetableFailure = FilterTimetableFailure(tMsg);
          when(mockGenerateScheduleForToday(any))
              .thenAnswer((_) async => Left(filterTimetableFailure));
          final expectedOrder = [
            const TimetableLoading(),
            const TimetableError(tMsg),
          ];
          expectLater(bloc.stream, emitsInOrder(expectedOrder));
          bloc.add(GetTimetableEvent(tDateTime));
          await untilCalled(mockGenerateScheduleForToday(NoParams()));
          verify(mockGenerateScheduleForToday(NoParams()));
        },
      );
    },
  );
}
