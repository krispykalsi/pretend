part of 'new_subject_bloc.dart';

abstract class NewSubjectEvent extends Equatable {
  const NewSubjectEvent();
}

class AddNewSubjectEvent extends NewSubjectEvent {
  final Subject subject;

  const AddNewSubjectEvent(this.subject);

  @override
  List<Object?> get props => const [];
}
