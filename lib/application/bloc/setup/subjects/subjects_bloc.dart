import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';

part 'subjects_event.dart';

part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final GetAllSubjects _getAllSubjects;

  SubjectsBloc({required GetAllSubjects getAllSubjects})
      : _getAllSubjects = getAllSubjects,
        super(Initial());

  late List<Subject> _subjects;

  @override
  Stream<SubjectsState> mapEventToState(SubjectsEvent event) async* {
    if (event is GetAllSubjectsEvent) {
      yield Loading();
      final subjectsOrFailure =
          await _getAllSubjects.call(GetAllSubjectsParams(DataSource.NETWORK));
      yield subjectsOrFailure.fold(
        (failure) => Error(msg: failure.message),
        (subs) {
          _subjects = subs;
          return Loaded(subjects: subs);
        },
      );
    } else if (event is OneOrMoreSubjectsSelectedEvent) {
      yield OneOrMoreSubjectsSelected(subjects: _subjects);
    } else if (event is NoSubjectsSelectedEvent) {
      yield Loaded(subjects: _subjects);
    }
  }
}
