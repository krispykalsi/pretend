import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';

import '../../../fixtures/timetable.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetTimetable])
void main() {
  late MockGetTimetable mockGetTimetable;
  late HomeBloc bloc;

  setUp(() {
    mockGetTimetable = MockGetTimetable();
    bloc = HomeBloc(
      getTimetable: mockGetTimetable,
    );
  });
  
  group('GetTimetable usecase', () {
    final tTimetable = getTestTimetableModel;

    test(
      'should get timetable from use case',
      () async {
        when(mockGetTimetable(any)).thenAnswer((_) async => Right(tTimetable));
        bloc.add(GetTimetableEvent());
        await untilCalled(mockGetTimetable(any));
        verify(mockGetTimetable(NoParams()));
      },
    );

    test(
        'should emit [Loading, Loaded] when data is gotten successfully',
        () async {
          when(mockGetTimetable(any)).thenAnswer((_) async => Right(tTimetable));
          final expectedOrder = [
            TimetableLoading(),
            TimetableLoaded(timetable: tTimetable),
          ];
          expectLater(bloc.stream, emitsInOrder(expectedOrder));
          bloc.add(GetTimetableEvent());
        },
    );

    test(
      'should emit [Loading, Error] when data is NOT gotten successfully',
          () async {
        final cacheFailure = CacheFailure();
        when(mockGetTimetable(any)).thenAnswer((_) async => Left(cacheFailure));
        final expectedOrder = [
          TimetableLoading(),
          TimetableError(message: cacheFailure.message),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(GetTimetableEvent());
      },
    );
  });
}
