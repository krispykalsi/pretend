import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetTimetable _getTimetable;

  HomeBloc({required GetTimetable getTimetable})
      : _getTimetable = getTimetable,
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield TimetableLoading();
      final either = await _getTimetable(NoParams());
      yield either.fold(
        (failure) => TimetableError(message: failure.message),
        (timetable) => TimetableLoaded(timetable: timetable),
      );
    }
  }
}
