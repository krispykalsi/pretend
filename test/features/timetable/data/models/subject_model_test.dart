import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSubjectModel = SubjectModel(
    name: "Computer Networks",
    code: "IT-502",
  );

  test('should be a subclass of Subject entity', () {
    expect(tSubjectModel, isA<Subject>());
  });

  test(
    'should return a valid SubjectModel',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("subject.json"));
      final result = SubjectModel.fromJson(jsonMap);
      expect(result, tSubjectModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      final result = tSubjectModel.toJson();
      final expectedJsonMap = {
        SubjectModelFields.NAME: "Computer Networks",
        SubjectModelFields.CODE: "IT-502"
      };
      expect(result, expectedJsonMap);
    },
  );
}
