import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/usecases/get_subjects_of_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';

import '../../../fixtures/timetable.dart';
import '../../../fixtures/timetable_subjects.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetTimetable, GetSubjectsOfTimetable])
void main() {
  late MockGetTimetable mockGetTimetable;
  late MockGetSubjectsOfTimetable mockGetSubjectsOfTimetable;
  late HomeBloc bloc;

  setUp(() {
    mockGetTimetable = MockGetTimetable();
    mockGetSubjectsOfTimetable = MockGetSubjectsOfTimetable();
    bloc = HomeBloc(
      getTimetable: mockGetTimetable,
      getSubjectsOfTimetable: mockGetSubjectsOfTimetable,
    );
  });

  group('GetTimetable usecase', () {
    final tTimetable = getTestTimetableModel;
    final tMapOfSubjects = getTestSubjectsOfTimetable;

    test(
      'should get timetable and its subjects from usecase',
      () async {
        when(mockGetTimetable(any)).thenAnswer((_) async => Right(tTimetable));
        when(mockGetSubjectsOfTimetable(any))
            .thenAnswer((_) async => Right(tMapOfSubjects));
        bloc.add(GetTimetableEvent());
        await untilCalled(mockGetTimetable(any));
        await untilCalled(mockGetSubjectsOfTimetable(any));
        verify(mockGetTimetable(NoParams()));
        verify(mockGetSubjectsOfTimetable(
          GetSubjectsOfTimetableParams(tTimetable.subjectCodes),
        ));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () {
        when(mockGetTimetable(any)).thenAnswer((_) async => Right(tTimetable));
        when(mockGetSubjectsOfTimetable(any))
            .thenAnswer((_) async => Right(tMapOfSubjects));
        final expectedOrder = [
          TimetableLoading(),
          TimetableLoaded(tTimetable, tMapOfSubjects),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(GetTimetableEvent());
      },
    );

    group(
      'should emit [Loading, Error] when data is NOT gotten successfully',
      () {
        final cacheFailure = CacheFailure();

        test(
          'on failure from GetTimetable usecase',
          () async {
            when(mockGetTimetable(any)).thenAnswer((_) async => Left(cacheFailure));
            final expectedOrder = [
              TimetableLoading(),
              TimetableError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(GetTimetableEvent());
            await untilCalled(mockGetTimetable(NoParams()));
            verify(mockGetTimetable(NoParams()));
          },
        );

        test(
          'on failure from GetSubjectsOfTimetable usecase',
          () async {
            when(mockGetTimetable(any)).thenAnswer((_) async => Right(tTimetable));
            when(mockGetSubjectsOfTimetable(any)).thenAnswer((_) async => Left(cacheFailure));
            final expectedOrder = [
              TimetableLoading(),
              TimetableError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(GetTimetableEvent());
            await untilCalled(mockGetSubjectsOfTimetable(any));
            verify(mockGetSubjectsOfTimetable(
              GetSubjectsOfTimetableParams(tTimetable.subjectCodes),
            ));
          },
        );
      },
    );
  });
}
