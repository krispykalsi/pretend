import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/presentation/setup/timetable/extensions.dart';

import '../../../fixtures/subject_wise_timetable.dart';
import '../../../fixtures/timetable.dart';

void main() {
  final testSWTimetable = getTestSubjectWiseTimetable;
  final expectedTimetable = getTestTimetable;

  group('should properly update timetable', () {
    test(
        'should add schedule for not occupied timeslots and delete previous ones',
        () {
      final timetable = Timetable({}, ["HU-351a"]);
      timetable.update(testSWTimetable);
      expect(timetable, expectedTimetable);
    });
  });

  test('should update schedule for existing timeslots', () {
    final timetable = Timetable(
      {
        Days.friday: {
          Timeslots.t1PM.dashed: Timeslot(
            slot: Timeslots.t1PM,
            classCategory: ClassCategories.tutorial,
            subjectCode: "HU-351a",
          )
        }
      },
      ["HU-351a"],
    );
    timetable.update(testSWTimetable);
    expect(timetable, expectedTimetable);
  });

  test('should remove subject key if its not present in the new timetable', () {
    final timetable = Timetable(
      {
        Days.monday: {
          Timeslots.t3PM.dashed: Timeslot(
            slot: Timeslots.t3PM,
            classCategory: ClassCategories.tutorial,
            subjectCode: "xyz-subject-code",
          )
        }
      },
      ["xyz-subject-code"],
    );
    timetable.update(testSWTimetable);
    expect(timetable, expectedTimetable);
  });
}
