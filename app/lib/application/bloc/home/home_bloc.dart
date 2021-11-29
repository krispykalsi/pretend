import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTimetableWithSubjects _getTimetableWithSubjects;
  final FilterTimetable _filterTimetable;

  HomeBloc({
    required GetTimetableWithSubjects getTimetableWithSubjects,
    required FilterTimetable filterTimetable,
  })  : _getTimetableWithSubjects = getTimetableWithSubjects,
        _filterTimetable = filterTimetable,
        super(const HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield const TimetableLoading();
      final timetableWithSubjectsEither =
          await _getTimetableWithSubjects(NoParams());
      yield* timetableWithSubjectsEither.fold(
        (failure) async* {
          yield failure is NoLocalDataFailure
              ? const TimetableNotFound()
              : TimetableError(failure.message);
        },
        (output) async* {
          final filteredScheduleEither = await _filterTimetable(
            FilterTimetableParams(event._now, output.timetable),
          );
          yield filteredScheduleEither.fold(
            (failure) => TimetableError(failure.message),
            (filteredSchedule) => TimetableLoaded(
              output.timetable,
              output.subjects,
              filteredSchedule,
            ),
          );
        },
      );
    }
  }
}
