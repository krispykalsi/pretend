import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTimetableWithSubjects _getTimetableWithSubjects;
  final FilterTimetable _filterTimetable;

  late TimetableWithSubjects _timetableWithSubjects;
  Timer? _timer;
  bool _timerInitialisationInProgress = false;

  HomeBloc({
    required GetTimetableWithSubjects getTimetableWithSubjects,
    required FilterTimetable filterTimetable,
  })  : _getTimetableWithSubjects = getTimetableWithSubjects,
        _filterTimetable = filterTimetable,
        super(const HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield const TimetableLoading();
      final timetableWithSubjectsEither =
          await _getTimetableWithSubjects(NoParams());
      yield* timetableWithSubjectsEither.fold(
        (failure) async* {
          yield failure is NoLocalDataFailure
              ? const TimetableNotFound()
              : TimetableError(failure.message);
        },
        (output) async* {
          _timetableWithSubjects = output;
          add(RefreshScheduleEvent(event._now));
        },
      );
    } else if (event is RefreshScheduleEvent) {
      yield await _filterSchedule(event._now);
      if (!_timerInitialisationInProgress) {
        initialiseTimer(event._now);
      }
    } else if (event is _TickEvent) {
      yield await _filterSchedule(DateTime.now());
    } else if (event is CancelTimetableRefreshTimerEvent) {
      _timer?.cancel();
    }
  }

  void initialiseTimer(DateTime now) async {
    _timerInitialisationInProgress = true;
    final minutesLeftUntilNextHour = 59 - now.minute;
    final secondsLeftUntilNextHour = 60 - now.second;
    await Future.delayed(Duration(
      minutes: minutesLeftUntilNextHour,
      seconds: secondsLeftUntilNextHour,
    ));
    add(_TickEvent());
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(hours: 1), (_) => add(_TickEvent()));
    _timerInitialisationInProgress = false;
  }

  Future<HomeState> _filterSchedule(DateTime now) async {
    final filteredScheduleEither = await _filterTimetable(
      FilterTimetableParams(now, _timetableWithSubjects.timetable),
    );
    return filteredScheduleEither.fold(
      (failure) => TimetableError(failure.message),
      (filteredSchedule) => TimetableLoaded(
        _timetableWithSubjects.timetable,
        _timetableWithSubjects.subjects,
        filteredSchedule,
      ),
    );
  }
}
