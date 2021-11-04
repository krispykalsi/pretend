import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
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

  @override
  Stream<SubjectsState> mapEventToState(SubjectsEvent event) async* {
    yield Loading();
    final subs =
        await _getAllSubjects.call(GetAllSubjectsParams(DataSource.NETWORK));
    yield* subs.fold(
      (failure) async* {
        yield Error(msg: _mapFailureToMessage(failure));
      },
      (subs) async* {
        yield Loaded(subjects: subs);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
