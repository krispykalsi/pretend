import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/timeslot.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tTimeSetModel = TimeslotModel(
    start: "8 AM",
    end: "10 AM",
    duration: 2,
    classCategory: ClassCategories.THEORY,
    subjectKey: "dsfFSFS3",
  );

  test('should be a subclass of TimeSet entity', () {
    expect(tTimeSetModel, isA<Timeslot>());
  });

  test(
    'should return a valid TimeSetModel',
        () async {
      final Map<String, dynamic> jsonMap = fixture("time_set.json");
      final result = TimeslotModel.fromJson(jsonMap);
      expect(result, tTimeSetModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
        () async {
      final result = tTimeSetModel.toJson();
      final expectedJsonMap = {
        TimeslotModelFields.START: "8 AM",
        TimeslotModelFields.END: "10 AM",
        TimeslotModelFields.DURATION: 2,
        TimeslotModelFields.CLASS_CATEGORY: ClassCategories.THEORY,
        TimeslotModelFields.SUBJECT_KEY: "dsfFSFS3",
      };
      expect(result, expectedJsonMap);
    },
  );
}
