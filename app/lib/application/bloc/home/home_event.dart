part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetTimetableEvent extends HomeEvent {
  final DateTime _now;

  const GetTimetableEvent(this._now);

  @override
  List<Object?> get props => [_now];
}

class _TickEvent extends HomeEvent {
  const _TickEvent();
}

class RefreshScheduleEvent extends HomeEvent {
  final DateTime _now;

  RefreshScheduleEvent(this._now);

  @override
  List<Object?> get props => [_now];
}

class CancelTimetableRefreshTimerEvent extends HomeEvent {
  const CancelTimetableRefreshTimerEvent();
}

class ExportTimetableEvent extends HomeEvent {
  const ExportTimetableEvent();
}