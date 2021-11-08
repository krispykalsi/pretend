import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/setup/timetable/timeslot_grid_tile_state.dart';

import 'typedefs.dart';

extension DayWise on Timetable {
  void addSubject(String subjectCode, WeekSelectionState selectionState) {
    selectionState
        .removeWhere((_, daySelectionState) => daySelectionState.isEmpty);
    timetable.addAll(selectionState.map((day, daySelectionState) {
      daySelectionState.removeWhere((_, tileState) => !tileState.isSelected);
      return MapEntry(
        day,
        daySelectionState.map((timeslot, tileState) {
          final classCategory = getClassCategoryFromColor(tileState.color);
          return MapEntry(
            timeslot.dashed,
            Timeslot(
              start: timeslot.start,
              end: timeslot.end,
              duration: 1,
              classCategory: classCategory,
              subjectCode: subjectCode,
            ),
          );
        }),
      );
    }));

    if (!subjectCodes.contains(subjectCode)) {
      subjectCodes.add(subjectCode);
    }
  }

  void removeSubject(String subjectCode) {
    timetable.forEach((_, timeslots) {
      timeslots.removeWhere(
        (_, timeslot) => timeslot.subjectCode == subjectCode,
      );
    });
    timetable.removeWhere((_, timeslots) => timeslots.isEmpty);
    subjectCodes.remove(subjectCode);
  }
}

extension SubjectWise on Timetable {
  SubjectWiseTimetable subjectWise() {
    final swTimetable = SubjectWiseTimetable();
    subjectCodes.forEach((subjectCode) {
      swTimetable[subjectCode] = {};
      timetable.forEach((day, timeslots) {
        timeslots.forEach((slotDashed, timeslot) {
          if (timeslot.subjectCode == subjectCode) {
            final timeslotEnum = getTimeslotFromDashed(slotDashed);
            final color = AppColors.classCategory[timeslot.classCategory]!;
            final selectionState = TimeslotGridTileState(true, color);
            swTimetable[subjectCode]!.putIfAbsent(day, () => {});
            swTimetable[subjectCode]![day]![timeslotEnum] = selectionState;
          }
        });
      });
    });
    return swTimetable;
  }
}
