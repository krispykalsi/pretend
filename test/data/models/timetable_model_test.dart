import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days_enum.dart';
import 'package:pretend/domain/entities/timeslot_enum.dart';
import 'package:pretend/domain/entities/timetable.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/timetable.dart';

void main() {
  final tTimetable = getTestTimetableModel;

  test('should be a subclass of TimeSet entity', () {
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
            TimeSets.T8AM: TimeslotModel(
              start: "8 AM",
              end: "10 AM",
              duration: 2,
              classCategory: ClassCategories.THEORY,
              subjectKey: "dsfFSFS3",
            ).toJson(),
            TimeSets.T9AM: TimeslotModel(
              start: "8 AM",
              end: "10 AM",
              duration: 2,
              classCategory: ClassCategories.THEORY,
              subjectKey: "dsfFSFS3",
            ).toJson(),
            TimeSets.T1PM: TimeslotModel(
              start: "1 PM",
              end: "2 PM",
              duration: 1,
              classCategory: ClassCategories.LAB,
              subjectKey: "fdsdfEv",
            ).toJson(),
            TimeSets.T11AM: TimeslotModel(
              start: "11 AM",
              end: "12 PM",
              duration: 1,
              classCategory: ClassCategories.THEORY,
              subjectKey: "FHVBVsf356",
            ).toJson(),
          }
        },
        TimetableModel.KEY_SUBJECTS: ["dsfFSFS3", "fdsdfEv", "FHVBVsf356"]
      };

      expect(result, expectedJsonMap);
    },
  );
}
