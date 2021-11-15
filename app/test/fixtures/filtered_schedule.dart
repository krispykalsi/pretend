import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';

final _filteredSchedule = {
  Filters.laterToday: {
    Timeslots.t1PM: const Timeslot(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.lab,
      subjectCode: "IT-502",
    ),
  },
  Filters.onGoing: {
    Timeslots.t11AM: const Timeslot(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "IT-504",
    ),
  },
  Filters.passed: {
    Timeslots.t8AM: const Timeslot(
      start: "8 AM",
      end: "9 AM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
    Timeslots.t9AM: const Timeslot(
      start: "9 AM",
      end: "10 AM",
      duration: 1,
      classCategory: ClassCategories.theory,
      subjectCode: "HU-351a",
    ),
  }
};

Map<Filters, Map<Timeslots, Timeslot>> get getTestFilteredSchedule =>
    _filteredSchedule;
