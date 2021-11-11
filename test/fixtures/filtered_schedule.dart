import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';

final _filteredSchedule = {
  Filters.laterToday: {
    Timeslots.T1PM: Timeslot(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.LAB,
      subjectCode: "IT-502",
    ),
  },
  Filters.onGoing: {
    Timeslots.T11AM: Timeslot(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectCode: "IT-504",
    ),
  },
  Filters.passed: {
    Timeslots.T8AM: Timeslot(
      start: "8 AM",
      end: "9 AM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectCode: "HU-351a",
    ),
    Timeslots.T9AM: Timeslot(
      start: "9 AM",
      end: "10 AM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectCode: "HU-351a",
    ),
  }
};

Map<Filters, Map<Timeslots, Timeslot>> get getTestFilteredSchedule =>
    _filteredSchedule;