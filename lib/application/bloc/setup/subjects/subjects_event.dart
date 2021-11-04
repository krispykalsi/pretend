part of 'subjects_bloc.dart';

abstract class SubjectsEvent extends Equatable {
  const SubjectsEvent();
}

class GetAllSubjectsEvent extends SubjectsEvent {
  const GetAllSubjectsEvent();

  @override
  List<Object?> get props => [];
}