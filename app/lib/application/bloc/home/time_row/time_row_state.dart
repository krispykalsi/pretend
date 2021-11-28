part of 'time_row_bloc.dart';

abstract class TimeRowState extends Equatable {
  const TimeRowState();
}

class TimeRowInitial extends TimeRowState {
  @override
  List<Object> get props => [];
}

class MinuteChanged extends TimeRowState {
  final newTime = DateTime.now();

  @override
  List<Object> get props => [newTime];
}
