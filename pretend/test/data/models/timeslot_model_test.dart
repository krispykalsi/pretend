import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/timeslot.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tTimeslotModel = TimeslotModel(
    start: "8 AM",
    end: "10 AM",
    duration: 2,
    classCategory: ClassCategories.THEORY,
    subjectCode: "HU-351a",
  );

  test('should be a subclass of Timeslot entity', () {
    expect(tTimeslotModel, isA<Timeslot>());
  });

  test(
    'should return a valid TimeslotModel',
        () async {
      final Map<String, dynamic> jsonMap = fixture("timeslot.json");
      final result = TimeslotModel.fromJson(jsonMap);
      expect(result, tTimeslotModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
        () async {
      final result = tTimeslotModel.toJson();
      final expectedJsonMap = {
        TimeslotModel.KEY_START: "8 AM",
        TimeslotModel.KEY_END: "10 AM",
        TimeslotModel.KEY_DURATION: 2,
        TimeslotModel.KEY_CLASS_CATEGORY: ClassCategories.THEORY,
        TimeslotModel.KEY_SUBJECT_CODE: "HU-351a",
      };
      expect(result, expectedJsonMap);
    },
  );
}
