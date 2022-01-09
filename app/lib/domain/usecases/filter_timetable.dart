import 'package:core/error.dart';
import 'package:core/extensions.dart';
import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

typedef FilteredSchedule = Map<Filters, Map<Timeslots, Timeslot>>;

class FilterTimetable extends UseCase<FilteredSchedule, FilterTimetableParams> {
  @override
  Future<Either<Failure, FilteredSchedule>> call(FilterTimetableParams params) {
    try {
      final day = Days.all[params.now.weekday - 1];
      final scheduleForToday = params.timetable.timetable[day] ?? {};
      final FilteredSchedule filteredSchedule = {};
      for (final division in Filters.values) {
        filteredSchedule[division] = {};
      }
      scheduleForToday.forEach((slot, info) {
        late Filters filter;
        if (params.now.isTimeBefore(slot.endTime)) {
          if (params.now.isTimeAfter(slot.startTime)) {
            filter = Filters.onGoing;
          } else {
            filter = Filters.laterToday;
          }
        } else {
          filter = Filters.passed;
        }
        filteredSchedule[filter]![slot] = info;
      });
      return Future.value(Right(filteredSchedule));
    } catch (e) {
      return Future.value(Left(FilterTimetableFailure(e.toString())));
    }
  }
}

class FilterTimetableParams extends Equatable {
  final DateTime now;
  final Timetable timetable;

  const FilterTimetableParams(this.now, this.timetable);

  @override
  List<Object?> get props => [now];
}
