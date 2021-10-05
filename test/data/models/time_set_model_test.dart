import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/time_set_model.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/time_set.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tTimeSetModel = TimeSetModel(
    start: "8 AM",
    end: "10 AM",
    duration: 2,
    classCategory: ClassCategories.THEORY,
    subjectKey: "dsfFSFS3",
  );

  test('should be a subclass of TimeSet entity', () {
    expect(tTimeSetModel, isA<TimeSet>());
  });

  test(
    'should return a valid TimeSetModel',
        () async {
      final Map<String, dynamic> jsonMap = fixture("time_set.json");
      final result = TimeSetModel.fromJson(jsonMap);
      expect(result, tTimeSetModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
        () async {
      final result = tTimeSetModel.toJson();
      final expectedJsonMap = {
        TimeSetModelFields.START: "8 AM",
        TimeSetModelFields.END: "10 AM",
        TimeSetModelFields.DURATION: 2,
        TimeSetModelFields.CLASS_CATEGORY: ClassCategories.THEORY,
        TimeSetModelFields.SUBJECT_KEY: "dsfFSFS3",
      };
      expect(result, expectedJsonMap);
    },
  );
}
