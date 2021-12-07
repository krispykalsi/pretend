import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/usecases/add_subject.dart';

part 'new_subject_event.dart';

part 'new_subject_state.dart';

class NewSubjectBloc extends Bloc<NewSubjectEvent, NewSubjectState> {
  final AddSubject _addSubject;

  NewSubjectBloc(this._addSubject) : super(const NewSubjectInitial());

  @override
  Stream<NewSubjectState> mapEventToState(NewSubjectEvent event) async* {
    if (event is AddNewSubjectEvent) {
      yield const NewSubjectBeingAdded();
      final eitherAddedOrNot =
          await _addSubject(AddSubjectParams(event.subject));
      yield eitherAddedOrNot.fold(
        (failure) => CouldNotAddNewSubject(failure.message),
        (_) => NewSubjectAdded(event.subject),
      );
      yield await Future.delayed(
        const Duration(seconds: 2),
        () => const NewSubjectInitial(),
      );
    }
  }
}
