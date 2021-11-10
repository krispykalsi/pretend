import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/setup/timetable/timeslot_grid_tile_state.dart';
import 'package:pretend/presentation/setup/timetable/typedefs.dart';

final SubjectWiseTimetable _subjectWiseTimetable = {
  "HU-351a": {
    Days.MONDAY: {},
    Days.TUESDAY: {},
    Days.WEDNESDAY: {},
    Days.THURSDAY: {},
    Days.FRIDAY: {
      Timeslots.T8AM: TimeslotGridTileState(
        true,
        AppColors.classCategory[ClassCategories.THEORY]!,
      ),
      Timeslots.T9AM: TimeslotGridTileState(
        true,
        AppColors.classCategory[ClassCategories.THEORY]!,
      ),
    },
  },
  "IT-502": {
    Days.MONDAY: {},
    Days.TUESDAY: {},
    Days.WEDNESDAY: {
      Timeslots.T7PM: TimeslotGridTileState(
        false,
        AppColors.classCategory[ClassCategories.TUTORIAL]!,
      ),
    },
    Days.THURSDAY: {},
    Days.FRIDAY: {
      Timeslots.T1PM: TimeslotGridTileState(
        true,
        AppColors.classCategory[ClassCategories.LAB]!,
      ),
    },
  },
  "IT-504": {
    Days.MONDAY: {
      Timeslots.T10AM: TimeslotGridTileState(
        false,
        AppColors.classCategory[ClassCategories.TUTORIAL]!,
      ),
    },
    Days.TUESDAY: {},
    Days.WEDNESDAY: {},
    Days.THURSDAY: {},
    Days.FRIDAY: {
      Timeslots.T11AM: TimeslotGridTileState(
        true,
        AppColors.classCategory[ClassCategories.THEORY]!,
      ),
    },
  },
};

SubjectWiseTimetable get getTestSubjectWiseTimetable => _subjectWiseTimetable;
