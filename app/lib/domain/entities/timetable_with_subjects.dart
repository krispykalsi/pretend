import 'package:equatable/equatable.dart';

import 'subject.dart';
import 'timetable.dart';

class TimetableWithSubjects extends Equatable {
  final Timetable timetable;
  final Map<String, Subject> subjects;

  const TimetableWithSubjects(
    this.timetable,
    this.subjects,
  );

  @override
  List<Object?> get props => [timetable, subjects];
}
