part of 'fetch_subjects_online_bloc.dart';

abstract class FetchSubjectsOnlineState extends Equatable {
  const FetchSubjectsOnlineState();
}

class FetchSubjectsOnlineInitial extends FetchSubjectsOnlineState {
  const FetchSubjectsOnlineInitial();

  @override
  List<Object> get props => [];
}

class Loading extends FetchSubjectsOnlineState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class Loaded extends FetchSubjectsOnlineState {
  final List<Subject> subjects;

  const Loaded({required this.subjects});

  @override
  List<Object> get props => [subjects];
}

class NoInternet extends FetchSubjectsOnlineState {
  const NoInternet();

  @override
  List<Object?> get props => [];
}

class CollegeNotConfigured extends FetchSubjectsOnlineState {
  const CollegeNotConfigured();

  @override
  List<Object?> get props => [];
}

class Error extends FetchSubjectsOnlineState {
  final String msg;

  const Error({required this.msg});

  @override
  List<Object?> get props => [msg];
}
