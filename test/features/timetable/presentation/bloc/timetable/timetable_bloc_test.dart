import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/features/timetable/domain/usecases/get_timetable.dart';
import 'package:pretend/features/timetable/domain/usecases/set_timetable.dart';
import 'package:pretend/features/timetable/presentation/bloc/timetable/timetable_bloc.dart';

import '../../../../../fixtures/timetable.dart';
import 'timetable_bloc_test.mocks.dart';

@GenerateMocks([GetTimetable, SetTimetable])
void main() {
  late MockGetTimetable mockGetTimetable;
  late MockSetTimetable mockSetTimetable;
  late TimetableBloc bloc;

  setUp(() {
    mockGetTimetable = MockGetTimetable();
    mockSetTimetable = MockSetTimetable();
    bloc = TimetableBloc(
      getTimetable: mockGetTimetable,
      setTimetable: mockSetTimetable,
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
          bloc.add(GetTimetableEvent());
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
        when(mockGetTimetable(any)).thenAnswer((_) async => Left(CacheFailure()));
        bloc.add(GetTimetableEvent());
        final expectedOrder = [
          TimetableLoading(),
          TimetableError(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(GetTimetableEvent());
      },
    );
  });
}
