import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/set_timetable.dart';

part 'timetable_setup_event.dart';

part 'timetable_setup_state.dart';

class TimetableSetupBloc
    extends Bloc<TimetableSetupEvent, TimetableSetupState> {
  final SetTimetable setTimetable;

  TimetableSetupBloc({required this.setTimetable})
      : super(const TimetableSetupInitial());

  @override
  Stream<TimetableSetupState> mapEventToState(
      TimetableSetupEvent event) async* {
    if (event is SaveTimetableEvent) {
      yield const TimetableSaving();
      final either = await setTimetable(SetTimetableParams(event.timetable));
      yield either.fold(
        (failure) => TimetableNotSavedError(message: failure.message),
        (success) => const TimetableSaved(),
      );
    } else if (event is ResetSetupEvent) {
      yield const TimetableSetupInitial();
    } else if (event is AllSubjectsConfiguredEvent) {
      yield const AllSubjectsConfigured();
    }
  }
}
