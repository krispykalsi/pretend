part of 'new_subject_bloc.dart';

abstract class NewSubjectState extends Equatable {
  const NewSubjectState();
}

class NewSubjectInitial extends NewSubjectState {
  const NewSubjectInitial();

  @override
  List<Object> get props => [];
}

class NewSubjectBeingAdded extends NewSubjectState {
  const NewSubjectBeingAdded();

  @override
  List<Object> get props => [];
}

class NewSubjectAdded extends NewSubjectState {
  const NewSubjectAdded();

  @override
  List<Object> get props => [];
}

class CouldNotAddNewSubject extends NewSubjectState {
  final String message;

  const CouldNotAddNewSubject(this.message);

  @override
  List<Object> get props => [];
}
