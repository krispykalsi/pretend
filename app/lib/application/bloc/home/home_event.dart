part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetTimetableEvent extends HomeEvent {
  final DateTime _now;

  const GetTimetableEvent(this._now);

  @override
  List<Object?> get props => [];
}
