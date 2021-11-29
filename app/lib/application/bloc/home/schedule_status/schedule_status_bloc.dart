import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';


part 'schedule_status_event.dart';
part 'schedule_status_state.dart';

class ScheduleStatusBloc extends Bloc<ScheduleStatusEvent, ScheduleStatusState> {
  ScheduleStatusBloc() : super(ScheduleStatusInitial());

  @override
  Stream<ScheduleStatusState> mapEventToState(ScheduleStatusEvent event) async* {
    if (event is GetStatusEvent) {
      final schedule = event._filteredSchedule;
      final isOngoingEmpty = schedule[Filters.onGoing]?.isEmpty ?? true;
      final isLaterTodayEmpty = schedule[Filters.laterToday]?.isEmpty ?? true;
      final isPassedEmpty = schedule[Filters.passed]?.isEmpty ?? true;

      if (isLaterTodayEmpty) {
        if (isOngoingEmpty) {
          if (isPassedEmpty) {
            yield const NoClassToday();
          } else {
            yield const DoneForToday();
          }
        } else {
          yield const LastClassGoingOn();
        }
      } else {
        yield const ClassesPending();
      }
    }
  }
}
