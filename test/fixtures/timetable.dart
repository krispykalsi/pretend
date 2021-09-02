import 'package:pretend/features/timetable/data/models/time_set_model.dart';
import 'package:pretend/features/timetable/data/models/timetable_model.dart';
import 'package:pretend/features/timetable/domain/entities/class_category_enum.dart';
import 'package:pretend/features/timetable/domain/entities/days_enum.dart';
import 'package:pretend/features/timetable/domain/entities/time_set_enum.dart';

final _tTimetableMap = {
  Days.FRIDAY: {
    TimeSets.T8AM: TimeSetModel(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T9AM: TimeSetModel(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T1PM: TimeSetModel(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.LAB,
      subjectKey: "fdsdfEv",
    ),
    TimeSets.T11AM: TimeSetModel(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectKey: "FHVBVsf356",
    ),
  }
};

final _tSubjectKeys = ["dsfFSFS3", "fdsdfEv", "FHVBVsf356"];

TimetableModel get getTestTimetableModel => TimetableModel(_tTimetableMap, _tSubjectKeys);
