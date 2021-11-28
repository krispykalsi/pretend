part of 'time_row_bloc.dart';

abstract class TimeRowEvent extends Equatable {
  const TimeRowEvent();
}

class InitialiseTimerEvent extends TimeRowEvent {
  const InitialiseTimerEvent();

  @override
  List<Object?> get props => const [];
}

class _TickEvent extends TimeRowEvent {
  const _TickEvent();

  @override
  List<Object?> get props => const [];
}

class CancelTimerEvent extends TimeRowEvent {
  const CancelTimerEvent();

  @override
  List<Object?> get props => const [];
}
