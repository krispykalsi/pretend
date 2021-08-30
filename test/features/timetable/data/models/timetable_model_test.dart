import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/features/timetable/data/models/time_set_model.dart';
import 'package:pretend/features/timetable/data/models/timetable_model.dart';
import 'package:pretend/features/timetable/domain/entities/class_category_enum.dart';
import 'package:pretend/features/timetable/domain/entities/days_enum.dart';
import 'package:pretend/features/timetable/domain/entities/time_set_enum.dart';
import 'package:pretend/features/timetable/domain/entities/timetable.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/timetable.dart';

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
        Days.FRIDAY: {
          TimeSets.T8AM: TimeSetModel(
            start: "8 AM",
            end: "10 AM",
            duration: 2,
            classCategory: ClassCategories.THEORY,
            subjectKey: "dsfFSFS3",
          ).toJson(),
          TimeSets.T9AM: TimeSetModel(
            start: "8 AM",
            end: "10 AM",
            duration: 2,
            classCategory: ClassCategories.THEORY,
            subjectKey: "dsfFSFS3",
          ).toJson(),
          TimeSets.T1PM: TimeSetModel(
            start: "1 PM",
            end: "2 PM",
            duration: 1,
            classCategory: ClassCategories.LAB,
            subjectKey: "fdsdfEv",
          ).toJson(),
          TimeSets.T11AM: TimeSetModel(
            start: "11 AM",
            end: "12 PM",
            duration: 1,
            classCategory: ClassCategories.THEORY,
            subjectKey: "FHVBVsf356",
          ).toJson(),
        }
      };

      expect(result, expectedJsonMap);
    },
  );
}
