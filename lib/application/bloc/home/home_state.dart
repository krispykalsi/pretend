part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class TimetableLoading extends HomeState {
  const TimetableLoading();

  @override
  List<Object?> get props => [];
}

class TimetableLoaded extends HomeState {
  final Timetable timetable;
  final Map<String, Subject> subjects;

  const TimetableLoaded(this.timetable, this.subjects);

  @override
  List<Object?> get props => [timetable];
}

class TimetableError extends HomeState {
  final String message;

  const TimetableError(this.message);

  @override
  List<Object?> get props => [message];
}
