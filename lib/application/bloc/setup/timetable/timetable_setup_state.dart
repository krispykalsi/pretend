part of 'timetable_setup_bloc.dart';

abstract class TimetableSetupState extends Equatable {
  const TimetableSetupState();
}

class TimetableSetupInitial extends TimetableSetupState {
  const TimetableSetupInitial();

  @override
  List<Object> get props => [];
}

class TimetableSaving extends TimetableSetupState {
  const TimetableSaving();

  @override
  List<Object> get props => [];
}

class TimetableSaved extends TimetableSetupState {
  const TimetableSaved();

  @override
  List<Object> get props => [];
}

class TimetableNotSavedError extends TimetableSetupState {
  final String message;

  const TimetableNotSavedError({required this.message});

  @override
  List<Object> get props => [];
}
