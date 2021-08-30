import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/features/timetable/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'subjects_local_datasource_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late SubjectsLocalDataSource localDataSource;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    localDataSource =
        SubjectsLocalDataSource(hive: mockHiveInterface);
  });

  test(
    'should return Subjects from Hive when there are some',
    () async {
      final tSubjectsJson = fixture("subjects.json");
      final tSubjects = SubjectModel.fromJsonList(tSubjectsJson);

      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.values)
          .thenReturn(tSubjectsJson);

      final result = await localDataSource.getSubjects();

      expect(result, tSubjects);
    },
  );

  test(
    'should return NoLocalDataFailure when no subjects present',
        () async {
      final tSubjectsJson = fixture("no_subject.json");
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.values)
          .thenReturn(tSubjectsJson);

      final call = localDataSource.getSubjects;

      expect(call(), throwsA(TypeMatcher<NoLocalDataException>()));
    },
  );
}
