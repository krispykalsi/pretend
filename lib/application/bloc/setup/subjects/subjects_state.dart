part of 'subjects_bloc.dart';

abstract class SubjectsState extends Equatable {
  const SubjectsState();
}

class Initial extends SubjectsState {
  @override
  List<Object> get props => [];
}

class Loading extends SubjectsState {
  @override
  List<Object?> get props => [];
}

class Loaded extends SubjectsState {
  final List<Subject> subjects;

  const Loaded({required this.subjects});

  @override
  List<Object> get props => [subjects];
}

class OneOrMoreSubjectsSelected extends SubjectsState {
  final List<Subject> subjects;

  const OneOrMoreSubjectsSelected({required this.subjects});

  @override
  List<Object> get props => [];
}

class Error extends SubjectsState {
  final String msg;

  const Error({required this.msg});

  @override
  List<Object?> get props => [msg];
}
