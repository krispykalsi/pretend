import 'package:flutter_test/flutter_test.dart';
import 'package:core/error.dart';
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
        TimetableModel.keyTimetable: {
          Days.friday: {
            Timeslots.t8AM.dashed: {
              TimeslotModel.keyStart: "8 AM",
              TimeslotModel.keyEnd: "9 AM",
              TimeslotModel.keyDuration: 1,
              TimeslotModel.keyClassCategory: ClassCategories.theory,
              TimeslotModel.keySubjectCode: "HU-351a",
            },
            Timeslots.t9AM.dashed: {
              TimeslotModel.keyStart: "9 AM",
              TimeslotModel.keyEnd: "10 AM",
              TimeslotModel.keyDuration: 1,
              TimeslotModel.keyClassCategory: ClassCategories.theory,
              TimeslotModel.keySubjectCode: "HU-351a",
            },
            Timeslots.t1PM.dashed: {
              TimeslotModel.keyStart: "1 PM",
              TimeslotModel.keyEnd: "2 PM",
              TimeslotModel.keyDuration: 1,
              TimeslotModel.keyClassCategory: ClassCategories.lab,
              TimeslotModel.keySubjectCode: "IT-502",
            },
            Timeslots.t11AM.dashed: {
              TimeslotModel.keyStart: "11 AM",
              TimeslotModel.keyEnd: "12 PM",
              TimeslotModel.keyDuration: 1,
              TimeslotModel.keyClassCategory: ClassCategories.theory,
              TimeslotModel.keySubjectCode: "IT-504",
            },
          }
        },
        TimetableModel.keySubjects: ["HU-351a", "IT-502", "IT-504"]
      };

      expect(result, expectedJsonMap);
    },
  );

  test('should throw NoLocalDataException when no timetable found in json', () {
    final Map<String, dynamic> jsonMap = {};
    expect(
      () => TimetableModel.fromJson(jsonMap),
      throwsA(const TypeMatcher<NoLocalDataException>()),
    );
  });
}
