import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';

final _filteredSchedule = {
  Filters.laterToday: {
    Timeslots.t1PM: const Timeslot(
      slot: Timeslots.t1PM,
      classCategory: ClassCategories.lab,
      subjectCode: "IT-502",
    ),
  },
  Filters.onGoing: {
    Timeslots.t11AM: const Timeslot(
      slot: Timeslots.t11AM,
      classCategory: ClassCategories.theory,
      subjectCode: "IT-504",
    ),
  },
  Filters.passed: {
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
  }
};

Map<Filters, Map<Timeslots, Timeslot>> get getTestFilteredSchedule =>
    _filteredSchedule;
