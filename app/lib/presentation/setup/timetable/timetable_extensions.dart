import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/presentation/setup/timetable/timeslot_grid_tile_state.dart';

import 'typedefs.dart';

extension DayWise on Timetable {
  void update(SubjectWiseTimetable swTimetable) {
    swTimetable.forEach(_addSubject);
    final List<String> subjectsToRemove = [];
    subjectCodes.forEach((subjectCode) {
      if (!swTimetable.keys.contains(subjectCode)) subjectsToRemove.add(subjectCode);
    });
    subjectsToRemove.forEach(_removeSubject);
  }

  void _addSubject(String subjectCode, WeekSelectionState selectionState) {
    selectionState.forEach((day, daySelectionState) {
      daySelectionState.removeWhere((_, tileState) => !tileState.isSelected);
      if (daySelectionState.isEmpty) return;
      final newTimeslots = daySelectionState.map((timeslot, tileState) {
        final classCategory = getClassCategoryFromColor(tileState.color);
        return MapEntry(
          timeslot,
          Timeslot(
            slot: timeslot,
            classCategory: classCategory,
            subjectCode: subjectCode,
          ),
        );
      });
      timetable.update(
        day,
        (prevTimeslotMap) => prevTimeslotMap..addAll(newTimeslots),
        ifAbsent: () => newTimeslots,
      );
    });

    if (!subjectCodes.contains(subjectCode)) {
      subjectCodes.add(subjectCode);
    }
  }

  void _removeSubject(String subjectCode) {
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
    for (var subjectCode in subjectCodes) {
      swTimetable[subjectCode] = {};
      timetable.forEach((day, timeslots) {
        timeslots.forEach((slot, timeslot) {
          if (timeslot.subjectCode == subjectCode) {
            final color = ClassCategory.colors[timeslot.classCategory]!;
            final selectionState = TimeslotGridTileState(true, color);
            swTimetable[subjectCode]!.putIfAbsent(day, () => {});
            swTimetable[subjectCode]![day]![slot] = selectionState;
          }
        });
      });
    }
    return swTimetable;
  }
}
