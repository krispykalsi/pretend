part of 'subjects_bloc.dart';

abstract class SubjectsEvent extends Equatable {
  const SubjectsEvent();
}

class GetAllSubjectsEvent extends SubjectsEvent {
  const GetAllSubjectsEvent();

  @override
  List<Object?> get props => [];
}

class OneOrMoreSubjectsSelectedEvent extends SubjectsEvent {
  const OneOrMoreSubjectsSelectedEvent();

  @override
  List<Object?> get props => [];
}

class NoSubjectsSelectedEvent extends SubjectsEvent {
  const NoSubjectsSelectedEvent();

  @override
  List<Object?> get props => [];
}
