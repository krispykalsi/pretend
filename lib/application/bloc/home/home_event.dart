part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetTimetableEvent extends HomeEvent {
  const GetTimetableEvent();

  @override
  List<Object?> get props => [];
}