part of 'schedule_status_bloc.dart';

abstract class ScheduleStatusEvent extends Equatable {
  const ScheduleStatusEvent();
}

class GetStatusEvent extends ScheduleStatusEvent {
  final FilteredSchedule _filteredSchedule;

  const GetStatusEvent(this._filteredSchedule);

  @override
  List<Object?> get props => [_filteredSchedule];
}
