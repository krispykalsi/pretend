import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/usecases/generate_schedule_for_today.dart';

import '../../../fixtures/filtered_schedule.dart';
import '../../../fixtures/timetable.dart';
import '../../../fixtures/timetable_subjects.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GenerateScheduleForToday])
void main() {
  late MockGenerateScheduleForToday mockGenerateScheduleForToday;
  late HomeBloc bloc;

  setUp(() {
    mockGenerateScheduleForToday = MockGenerateScheduleForToday();
    bloc = HomeBloc(
      generateScheduleForToday: mockGenerateScheduleForToday,
    );
  });

  group('GetTimetable usecase', () {
    final tTimetable = getTestTimetableModel;
    final tSubjects = getTestSubjectsOfTimetable;
    final tFilteredSchedule = getTestFilteredSchedule;

    final generateScheduleForTodayOutput = GenerateScheduleForTodayOutput(
      tTimetable,
      tSubjects,
      tFilteredSchedule,
    );

    final tDateTime = DateFormat("H:mm").parse("11:05");
    final tParams = GenerateScheduleForTodayParams(tDateTime);

    test(
      'should get timetable and its subjects from usecase',
      () async {
        when(mockGenerateScheduleForToday(any))
            .thenAnswer((_) async => Right(generateScheduleForTodayOutput));
        bloc.add(GetTimetableEvent(tDateTime));
        await untilCalled(mockGenerateScheduleForToday(any));
        verify(mockGenerateScheduleForToday(tParams));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () {
        when(mockGenerateScheduleForToday(any))
            .thenAnswer((_) async => Right(generateScheduleForTodayOutput));
        final expectedOrder = [
          TimetableLoading(),
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
              TimetableLoading(),
              TimetableError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(GetTimetableEvent(tDateTime));
            await untilCalled(mockGenerateScheduleForToday(tParams));
            verify(mockGenerateScheduleForToday(tParams));
          },
        );

        test(
          'on GenerateScheduleFailure',
          () async {
            final tMsg = "xyz error";
            final generateScheduleFailure = GenerateScheduleFailure(tMsg);
            when(mockGenerateScheduleForToday(any))
                .thenAnswer((_) async => Left(generateScheduleFailure));
            final expectedOrder = [
              TimetableLoading(),
              TimetableError(tMsg),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(GetTimetableEvent(tDateTime));
            await untilCalled(mockGenerateScheduleForToday(tParams));
            verify(mockGenerateScheduleForToday(tParams));
          },
        );
      },
    );
  });
}
