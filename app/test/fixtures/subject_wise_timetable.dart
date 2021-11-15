import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/presentation/setup/timetable/timeslot_grid_tile_state.dart';
import 'package:pretend/presentation/setup/timetable/typedefs.dart';

final SubjectWiseTimetable _subjectWiseTimetable = {
  "HU-351a": {
    Days.monday: {},
    Days.tuesday: {},
    Days.wednesday: {},
    Days.thursday: {},
    Days.friday: {
      Timeslots.t8AM: TimeslotGridTileState(
        true,
        ClassCategory.colors[ClassCategories.theory]!,
      ),
      Timeslots.t9AM: TimeslotGridTileState(
        true,
        ClassCategory.colors[ClassCategories.theory]!,
      ),
    },
  },
  "IT-502": {
    Days.monday: {},
    Days.tuesday: {},
    Days.wednesday: {
      Timeslots.t7PM: TimeslotGridTileState(
        false,
        ClassCategory.colors[ClassCategories.tutorial]!,
      ),
    },
    Days.thursday: {},
    Days.friday: {
      Timeslots.t1PM: TimeslotGridTileState(
        true,
        ClassCategory.colors[ClassCategories.lab]!,
      ),
    },
  },
  "IT-504": {
    Days.monday: {
      Timeslots.t10AM: TimeslotGridTileState(
        false,
        ClassCategory.colors[ClassCategories.tutorial]!,
      ),
    },
    Days.tuesday: {},
    Days.wednesday: {},
    Days.thursday: {},
    Days.friday: {
      Timeslots.t11AM: TimeslotGridTileState(
        true,
        ClassCategory.colors[ClassCategories.theory]!,
      ),
    },
  },
};

SubjectWiseTimetable get getTestSubjectWiseTimetable => _subjectWiseTimetable;
