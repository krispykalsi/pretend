import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/get_subjects_of_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetTimetable _getTimetable;
  GetSubjectsOfTimetable _getSubjectsOfTimetable;

  HomeBloc({
    required GetTimetable getTimetable,
    required GetSubjectsOfTimetable getSubjectsOfTimetable,
  })  : _getTimetable = getTimetable,
        _getSubjectsOfTimetable = getSubjectsOfTimetable,
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield TimetableLoading();
      final eitherTimetableOrFailure = await _getTimetable(NoParams());
      yield* eitherTimetableOrFailure.fold(
        (failure) => Stream.value(TimetableError(failure.message)),
        (timetable) async* {
          final eitherSubjectsOrFailure = await _getSubjectsOfTimetable(
            GetSubjectsOfTimetableParams(timetable.subjectCodes),
          );
          yield eitherSubjectsOrFailure.fold(
            (failure) => TimetableError(failure.message),
            (subjects) => TimetableLoaded(timetable, subjects),
          );
        },
      );
    }
  }
}
