part of 'timetable_setup_bloc.dart';

abstract class TimetableSetupEvent extends Equatable {
  const TimetableSetupEvent();
}

class SaveTimetableEvent extends TimetableSetupEvent {
  final Timetable timetable;

  const SaveTimetableEvent({required this.timetable});

  @override
  List<Object> get props => [timetable];
}

class ResetSetupEvent extends TimetableSetupEvent {
  const ResetSetupEvent();

  @override
  List<Object> get props => [];
}

class AllSubjectsConfiguredEvent extends TimetableSetupEvent {
  const AllSubjectsConfiguredEvent();

  @override
  List<Object> get props => [];
}
