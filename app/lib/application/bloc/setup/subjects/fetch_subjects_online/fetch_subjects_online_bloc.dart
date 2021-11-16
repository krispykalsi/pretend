import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/error.dart';
import 'package:core/network.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';

part 'fetch_subjects_online_event.dart';

part 'fetch_subjects_online_state.dart';

class FetchSubjectsOnlineBloc
    extends Bloc<FetchSubjectsOnlineEvent, FetchSubjectsOnlineState> {
  final GetAllSubjects _getAllSubjects;

  FetchSubjectsOnlineBloc({required GetAllSubjects getAllSubjects})
      : _getAllSubjects = getAllSubjects,
        super(FetchSubjectsOnlineInitial());

  @override
  Stream<FetchSubjectsOnlineState> mapEventToState(
      FetchSubjectsOnlineEvent event) async* {
    if (event is FetchSubjectsEvent) {
      yield Loading();
      final subjectsEither =
          await _getAllSubjects(GetAllSubjectsParams(DataSource.NETWORK));
      yield subjectsEither.fold(
        (failure) {
          if (failure is NoInternetFailure) {
            return NoInternet();
          } else if (failure is CollegeNotConfiguredFailure) {
            return CollegeNotConfigured();
          } else {
            return Error(msg: failure.message);
          }
        },
        (subjects) => Loaded(subjects: subjects),
      );
    }
  }
}
