part of 'fetch_subjects_online_bloc.dart';

abstract class FetchSubjectsOnlineEvent extends Equatable {
  const FetchSubjectsOnlineEvent();
}

class FetchSubjectsEvent extends FetchSubjectsOnlineEvent {
  const FetchSubjectsEvent();

  @override
  List<Object?> get props => [];
}
