part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();
}

class GetTimetableEvent extends TimetableEvent {
  @override
  List<Object?> get props => [];
}

class SetTimetableEvent extends TimetableEvent {
  @override
  List<Object?> get props => [];
}