import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';
import 'package:pretend/domain/usecases/set_timetable.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final GetTimetable getTimetable;
  final SetTimetable setTimetable;

  TimetableBloc({
    required this.getTimetable,
    required this.setTimetable,
  }) : super(TimetableInitial());

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetTimetableEvent:
        yield TimetableLoading();
        final either = await getTimetable(NoParams());
        yield either.fold(
          (failure) => TimetableError(message: _mapFailureToMessage(failure)),
          (timetable) => TimetableLoaded(timetable: timetable),
        );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure: return SERVER_FAILURE_MESSAGE;
      case CacheFailure: return CACHE_FAILURE_MESSAGE;
      default: return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
