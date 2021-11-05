import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/timetable.dart';

void main() {
  final tTimetable = getTestTimetableModel;

  test('should be a subclass of Timeslot entity', () {
    expect(tTimetable, isA<Timetable>());
  });

  test(
    'should return a valid TimetableModel',
    () async {
      final Map<String, dynamic> jsonMap = fixture("timetable.json");
      final result = TimetableModel.fromJson(jsonMap);
      expect(result, tTimetable);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      final result = tTimetable.toJson();
      final expectedJsonMap = {
        TimetableModel.KEY_TIMETABLE: {
          Days.FRIDAY: {
            Timeslots.T8AM.dashed: {
              TimeslotModel.KEY_START: "8 AM",
              TimeslotModel.KEY_END: "10 AM",
              TimeslotModel.KEY_DURATION: 2,
              TimeslotModel.KEY_CLASS_CATEGORY: ClassCategories.THEORY,
              TimeslotModel.KEY_SUBJECT_CODE: "HU-351a",
            },
            Timeslots.T9AM.dashed: {
              TimeslotModel.KEY_START: "8 AM",
              TimeslotModel.KEY_END: "10 AM",
              TimeslotModel.KEY_DURATION: 2,
              TimeslotModel.KEY_CLASS_CATEGORY: ClassCategories.THEORY,
              TimeslotModel.KEY_SUBJECT_CODE: "HU-351a",
            },
            Timeslots.T1PM.dashed: {
              TimeslotModel.KEY_START: "1 PM",
              TimeslotModel.KEY_END: "2 PM",
              TimeslotModel.KEY_DURATION: 1,
              TimeslotModel.KEY_CLASS_CATEGORY: ClassCategories.LAB,
              TimeslotModel.KEY_SUBJECT_CODE: "IT-502",
            },
            Timeslots.T11AM.dashed: {
              TimeslotModel.KEY_START: "11 AM",
              TimeslotModel.KEY_END: "12 PM",
              TimeslotModel.KEY_DURATION: 1,
              TimeslotModel.KEY_CLASS_CATEGORY: ClassCategories.THEORY,
              TimeslotModel.KEY_SUBJECT_CODE: "IT-504",
            },
          }
        },
        TimetableModel.KEY_SUBJECTS: ["HU-351a", "IT-502", "IT-504"]
      };

      expect(result, expectedJsonMap);
    },
  );
}
