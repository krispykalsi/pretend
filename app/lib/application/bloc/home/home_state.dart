part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => const [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class TimetableLoading extends HomeState {
  const TimetableLoading();
}

class TimetableLoaded extends HomeState {
  final Timetable timetable;
  final Map<String, Subject> subjects;
  final FilteredSchedule filteredSchedule;

  const TimetableLoaded(this.timetable, this.subjects, this.filteredSchedule);

  @override
  List<Object?> get props => [timetable, filteredSchedule];
}

class TimetableNotFound extends HomeState {
  const TimetableNotFound();
}

class TimetableError extends HomeState {
  final String message;

  const TimetableError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExportInProgress extends HomeState {
  const ExportInProgress();
}

class ExportSuccessful extends HomeState {
  final String pathToFile;

  const ExportSuccessful(this.pathToFile);

  @override
  List<Object?> get props => [pathToFile];
}

class ExportFailed extends HomeState {
  final String message;

  const ExportFailed(this.message);

  @override
  List<Object?> get props => [message];
}
