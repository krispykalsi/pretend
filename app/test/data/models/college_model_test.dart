import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/college_model.dart';
import 'package:pretend/domain/entities/college.dart';

void main() {
  final expectedCollegeModel = CollegeModel(
    "1",
    "Delhi Technological University",
    "Rohini",
  );

  test('should be a subclass of College entity', () {
    expect(expectedCollegeModel, isA<College>());
  });

  test('should return a valid CollegeModel', () async {
    final csvList = [
      ["code", "name", "city"],
      ["1", "Delhi Technological University", "Rohini"]
    ];
    final result = CollegeModel.fromCsv(csvList.elementAt(1));
    expect(result, expectedCollegeModel);
  });
}
