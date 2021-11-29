import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

final _tTimetableMap = {
  Days.friday: {
    Timeslots.t8AM: const Timeslot(
      slot: Timeslots.t8AM,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
    Timeslots.t9AM: const Timeslot(
      slot: Timeslots.t9AM,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
    Timeslots.t1PM: const Timeslot(
      slot: Timeslots.t1PM,
      classCategory: ClassCategories.lab,
      subjectCode: "IT-502",
    ),
    Timeslots.t11AM: const Timeslot(
      slot: Timeslots.t11AM,
      classCategory: ClassCategories.theory,
      subjectCode: "IT-504",
    ),
  }
};

final _tSubjectKeys = ["HU-351a", "IT-502", "IT-504"];

Timetable get getTestTimetable => Timetable(_tTimetableMap, _tSubjectKeys);
TimetableModel get getTestTimetableModel => TimetableModel.fromEntity(getTestTimetable);
