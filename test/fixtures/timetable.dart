import 'package:pretend/features/timetable/domain/entities/class_category_enum.dart';
import 'package:pretend/features/timetable/domain/entities/days_enum.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';
import 'package:pretend/features/timetable/domain/entities/time_set_enum.dart';
import 'package:pretend/features/timetable/domain/entities/timetable.dart';

final _tTimetableMap = {
  Days.FRIDAY: {
    TimeSets.T8AM: TimeSet(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T9AM: TimeSet(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T1PM: TimeSet(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.LAB,
      subjectKey: "fdsdfEv",
    ),
    TimeSets.T11AM: TimeSet(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectKey: "FHVBVsf356",
    ),
  }
};

Timetable get getTestTimetable => Timetable(_tTimetableMap);
