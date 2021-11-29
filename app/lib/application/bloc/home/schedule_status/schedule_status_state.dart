part of 'schedule_status_bloc.dart';

abstract class ScheduleStatusState extends Equatable {
  const ScheduleStatusState();
}

class ScheduleStatusInitial extends ScheduleStatusState {
  @override
  List<Object> get props => [];
}

class ClassesPending extends ScheduleStatusState {
  const ClassesPending();

  @override
  List<Object?> get props => const [];
}

class DoneForToday extends ScheduleStatusState {
  const DoneForToday();

  @override
  List<Object?> get props => const [];
}

class NoClassToday extends ScheduleStatusState {
  const NoClassToday();

  @override
  List<Object?> get props => const [];
}

class LastClassGoingOn extends ScheduleStatusState {
  const LastClassGoingOn();

  @override
  List<Object?> get props => const [];
}
