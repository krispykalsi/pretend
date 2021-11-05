import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslots.dart';

final _tTimetableMap = {
  Days.FRIDAY: {
    TimeSlots.T8AM: TimeslotModel(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectCode: "HU-351a",
    ),
    TimeSlots.T9AM: TimeslotModel(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectCode: "HU-351a",
    ),
    TimeSlots.T1PM: TimeslotModel(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.LAB,
      subjectCode: "IT-502",
    ),
    TimeSlots.T11AM: TimeslotModel(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectCode: "IT-504",
    ),
  }
};

final _tSubjectKeys = ["HU-351a", "IT-502", "IT-504"];

TimetableModel get getTestTimetableModel => TimetableModel(_tTimetableMap, _tSubjectKeys);
