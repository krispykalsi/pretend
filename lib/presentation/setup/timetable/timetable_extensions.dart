import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/presentation/common/app_colors.dart';

import 'typedefs.dart';

extension DayWiseTimetable on Timetable {
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
            timeslot,
            Timeslot(
              start: "",
              end: "",
              duration: 0,
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
