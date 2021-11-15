part of 'timetable_setup_bloc.dart';

abstract class TimetableSetupState extends Equatable {
  const TimetableSetupState();
}

class TimetableSetupInitial extends TimetableSetupState {
  const TimetableSetupInitial();

  @override
  List<Object> get props => const [];
}

class AllSubjectsConfigured extends TimetableSetupState {
  const AllSubjectsConfigured();

  @override
  List<Object> get props => const [];
}

class TimetableSaving extends TimetableSetupState {
  const TimetableSaving();

  @override
  List<Object> get props => const [];
}

class TimetableSaved extends TimetableSetupState {
  const TimetableSaved();

  @override
  List<Object> get props => const [];
}

class TimetableNotSavedError extends TimetableSetupState {
  final String message;

  const TimetableNotSavedError({required this.message});

  @override
  List<Object> get props => const [];
}
