import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/usecases/export_timetable.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTimetableWithSubjects _getTimetableWithSubjects;
  final FilterTimetable _filterTimetable;
  final ExportTimetable _exportTimetable;

  late TimetableWithSubjects _timetableWithSubjects;
  Timer? _timer;
  bool _timerInitialisationInProgress = false;

  HomeBloc({
    required GetTimetableWithSubjects getTimetableWithSubjects,
    required FilterTimetable filterTimetable,
    required ExportTimetable exportTimetable,
  })  : _getTimetableWithSubjects = getTimetableWithSubjects,
        _filterTimetable = filterTimetable,
        _exportTimetable = exportTimetable,
        super(const HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTimetableEvent) {
      yield* _handleGetTimetableEvent(event._now);
    } else if (event is RefreshScheduleEvent) {
      yield await _filterSchedule(event._now);
      if (!_timerInitialisationInProgress) {
        _initialiseTimer(event._now);
      }
    } else if (event is ExportTimetableEvent) {
      yield* _handleExportTimetableEvent(event.name);
    } else if (event is _TickEvent) {
      yield await _filterSchedule(DateTime.now());
    } else if (event is CancelTimetableRefreshTimerEvent) {
      _timer?.cancel();
    }
  }

  Stream<HomeState> _handleExportTimetableEvent(String name) async* {
    yield const ExportInProgress();
    final params = ExportTimetableParams(name, _timetableWithSubjects);
    final exportEither = await _exportTimetable(params);
    yield exportEither.fold(
      (failure) => ExportFailed(failure.message),
      (filePath) => ExportSuccessful(filePath),
    );
  }

  Stream<HomeState> _handleGetTimetableEvent(DateTime now) async* {
    yield const TimetableLoading();
    final timetableWithSubjectsEither =
        await _getTimetableWithSubjects(NoParams());
    yield* timetableWithSubjectsEither.fold(
      (failure) async* {
        yield failure is NoLocalDataFailure
            ? const TimetableNotFound()
            : TimetableError(failure.message);
      },
      (tws) async* {
        _timetableWithSubjects = tws;
        add(RefreshScheduleEvent(now));
      },
    );
  }

  void _initialiseTimer(DateTime now) async {
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
