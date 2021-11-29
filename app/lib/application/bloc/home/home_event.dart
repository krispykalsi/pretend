part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetTimetableEvent extends HomeEvent {
  final DateTime _now;

  const GetTimetableEvent(this._now);

  @override
  List<Object?> get props => [_now];
}

class _TickEvent extends HomeEvent {
  const _TickEvent();

  @override
  List<Object?> get props => [];
}

class RefreshScheduleEvent extends HomeEvent {
  final DateTime _now;

  RefreshScheduleEvent(this._now);

  @override
  List<Object?> get props => [_now];
}

class CancelTimetableRefreshTimerEvent extends HomeEvent {
  const CancelTimetableRefreshTimerEvent();

  @override
  List<Object?> get props => const [];
}
