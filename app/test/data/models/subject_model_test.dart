import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/subject_model.dart';
import 'package:pretend/domain/entities/subject.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tSubjectModel = SubjectModel(
    name: "Computer Networks",
    code: "IT-502",
  );

  test('should be a subclass of Subject entity', () {
    expect(tSubjectModel, isA<Subject>());
  });

  test(
    'should return a valid SubjectModel',
    () async {
      final Map<String, dynamic> jsonMap = fixture("subject.json");
      final result = SubjectModel.fromJson(jsonMap);
      expect(result, tSubjectModel);
    },
  );

  test(
    'should return a valid List of SubjectModels',
    () async {
      final List<dynamic> jsonList = fixture("subjects.json");
      final result = SubjectModel.listFromJson(jsonList);

      final expectedSubjects = [
        const SubjectModel(
          name: "Computer Networks",
          code: "IT-502",
        ),
        const SubjectModel(
          name: "International Trade",
          code: "HU-351a",
        ),
      ];
      expect(result, expectedSubjects);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      final result = tSubjectModel.toJson();
      final expectedJsonMap = {
        SubjectModelFields.name: "Computer Networks",
        SubjectModelFields.code: "IT-502"
      };
      expect(result, expectedJsonMap);
    },
  );

  test(
    'should return a valid JSON map of SubjectModels',
    () async {
      final expectedJsonMap = {
        "HU-351a": const SubjectModel(name: "International Trade", code: "HU-351a"),
        "IT-502": const SubjectModel(name: "Computer Networks", code: "IT-502"),
        "IT-504": const SubjectModel(name: "Theory of Computing", code: "IT-504")
      };

      final jsonMap = fixture("timetable_subjects.json");
      final result = SubjectModel.mapFromJson(jsonMap);

      expect(result, expectedJsonMap);
    },
  );
}
