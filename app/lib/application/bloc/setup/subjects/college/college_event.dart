part of 'college_bloc.dart';

abstract class CollegeEvent extends Equatable {
  const CollegeEvent();
}

class GetCollegesEvent extends CollegeEvent {
  const GetCollegesEvent();

  @override
  List<Object?> get props => const [];
}

class SetCollegeIDEvent extends CollegeEvent {
  final String id;

  const SetCollegeIDEvent(this.id);

  @override
  List<Object?> get props => const [];
}
