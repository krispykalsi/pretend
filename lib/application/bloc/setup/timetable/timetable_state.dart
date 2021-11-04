part of 'timetable_bloc.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();
}

class TimetableInitial extends TimetableState {
  @override
  List<Object> get props => [];
}

class TimetableLoading extends TimetableState {
  @override
  List<Object?> get props => [];
}

class TimetableLoaded extends TimetableState {
  final Timetable timetable;

  TimetableLoaded({required this.timetable});

  @override
  List<Object?> get props => [timetable];
}

class TimetableError extends TimetableState {
  final String message;

  TimetableError({required this.message});

  @override
  List<Object?> get props => [message];
}