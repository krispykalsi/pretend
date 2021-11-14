import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/models/subject_model.dart';

import '../../fixtures/fixture_reader.dart';
import 'subjects_local_datasource_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late SubjectsLocalDataSource localDataSource;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    localDataSource = SubjectsLocalDataSource(hive: mockHiveInterface);
  });

  void runCacheExceptionTestOn(Function closure) {
    test(
      'should throw CacheException in case of any other exceptions/errors',
      () async {
        when(mockHiveInterface.openBox(any)).thenThrow(Exception());
        expect(closure, throwsA(TypeMatcher<CacheException>()));
        verify(mockHiveInterface.openBox(any));
        verifyNoMoreInteractions(mockHiveBox);
        verifyNoMoreInteractions(mockHiveInterface);
      },
    );
  }

  group('GetAllSubjects', () {
    test(
      'should return Subjects from Hive when there are some',
      () async {
        final tSubjectsJson = fixture("subjects.json");
        final tSubjects = SubjectModel.listFromJson(tSubjectsJson);

        when(mockHiveInterface.openBox(any))
            .thenAnswer((_) async => mockHiveBox);
        when(mockHiveBox.values).thenReturn(tSubjectsJson);

        final result = await localDataSource.getAllSubjects();

        expect(result, tSubjects);
        verify(mockHiveInterface.openBox(any));
        verify(mockHiveBox.values);
        verifyNoMoreInteractions(mockHiveBox);
        verifyNoMoreInteractions(mockHiveInterface);
      },
    );

    test(
      'should throw NoLocalDataException when no subjects present',
      () async {
        final tSubjectsJson = fixture("no_subject.json");
        when(mockHiveInterface.openBox(any))
            .thenAnswer((_) async => mockHiveBox);
        when(mockHiveBox.values).thenReturn(tSubjectsJson);

        final call = localDataSource.getAllSubjects;

        expect(call, throwsA(TypeMatcher<NoLocalDataException>()));
        verify(mockHiveInterface.openBox(any));
        verifyNoMoreInteractions(mockHiveBox);
        verifyNoMoreInteractions(mockHiveInterface);
      },
    );

    runCacheExceptionTestOn(() => localDataSource.getAllSubjects());
  });

  group('GetSubjects', () {
    final tSubjectKeys = ["HU-351a", "IT-502", "IT-504"];
    final tSubjectsJson = fixture("timetable_subjects.json");
    final tSubjects = SubjectModel.mapFromJson(tSubjectsJson);
    test(
      'should return map of Subjects of the given keys from Hive',
      () async {
        when(mockHiveInterface.openBox(any))
            .thenAnswer((_) async => mockHiveBox);
        for (String key in tSubjectsJson.keys) {
          when(mockHiveBox.get(key)).thenReturn(tSubjectsJson[key]);
        }

        final result = await localDataSource.getSubjects(tSubjectKeys);

        expect(result, tSubjects);
        verify(mockHiveInterface.openBox(any));
        for (String key in tSubjectsJson.keys) {
          verify(mockHiveBox.get(key));
        }
        verifyNoMoreInteractions(mockHiveBox);
        verifyNoMoreInteractions(mockHiveInterface);
      },
    );

    runCacheExceptionTestOn(() => localDataSource.getSubjects(tSubjectKeys));
  });
}
