import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

final _tTimetableMap = {
  Days.friday: {
    Timeslots.t8AM.dashed: const Timeslot(
      start: "8 AM",
      end: "9 AM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
    Timeslots.t9AM.dashed: const Timeslot(
      start: "9 AM",
      end: "10 AM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
    Timeslots.t1PM.dashed: const Timeslot(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.lab,
      subjectCode: "IT-502",
    ),
    Timeslots.t11AM.dashed: const Timeslot(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "IT-504",
    ),
  }
};

final _tSubjectKeys = ["HU-351a", "IT-502", "IT-504"];

Timetable get getTestTimetable => Timetable(_tTimetableMap, _tSubjectKeys);
TimetableModel get getTestTimetableModel => TimetableModel.fromEntity(getTestTimetable);