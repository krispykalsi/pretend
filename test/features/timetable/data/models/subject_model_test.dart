import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';

void main() {
  final tSubjectModel = SubjectModel(
    name: "Computer Networks",
    code: "IT-502",
  );

  test("should be a subclass of Subject entity", () {
    expect(tSubjectModel, isA<Subject>());
  });
}