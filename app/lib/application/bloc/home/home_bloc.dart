import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/generate_schedule_for_today.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GenerateScheduleForToday _generateScheduleForToday;

  HomeBloc({
    required GenerateScheduleForToday generateScheduleForToday,
  })  : _generateScheduleForToday = generateScheduleForToday,
        super(const HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield const TimetableLoading();
      final scheduleForTodayEither = await _generateScheduleForToday(
        GenerateScheduleForTodayParams(event._now),
      );
      yield scheduleForTodayEither.fold(
        (failure) => failure is NoLocalDataFailure
            ? const TimetableNotFound()
            : TimetableError(failure.message),
        (scheduleForToday) => TimetableLoaded(
          scheduleForToday.timetable,
          scheduleForToday.subjects,
          scheduleForToday.filteredSchedule,
        ),
      );
    }
  }
}
