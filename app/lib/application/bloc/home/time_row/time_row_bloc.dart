import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_row_event.dart';

part 'time_row_state.dart';

class TimeRowBloc extends Bloc<TimeRowEvent, TimeRowState> {
  Timer? _timer;

  TimeRowBloc() : super(TimeRowInitial());

  @override
  Stream<TimeRowState> mapEventToState(TimeRowEvent event) async* {
    if (event is InitialiseTimerEvent) {
      yield MinuteChanged();
      final secLeftForNextMinute = 60 - DateTime.now().second;
      await Future.delayed(Duration(seconds: secLeftForNextMinute));
      yield MinuteChanged();
      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(minutes: 1),
        (_) => add(const _TickEvent()),
      );
    } else if (event is CancelTimerEvent) {
      _timer?.cancel();
    } else if (event is _TickEvent) {
      yield MinuteChanged();
    }
  }
}
