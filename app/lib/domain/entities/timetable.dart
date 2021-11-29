import 'package:equatable/equatable.dart';

import 'timeslot.dart';
import 'timeslots.dart';

typedef TimetableMap = Map<String, Map<Timeslots, Timeslot>>;

class Timetable extends Equatable {
  final TimetableMap timetable;
  final List<String> subjectCodes;

  const Timetable(this.timetable, this.subjectCodes);

  @override
  List<Object?> get props => [timetable];
}
