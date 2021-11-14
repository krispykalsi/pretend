import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/data/models/timetable_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/timetable.dart';
import 'subjects_local_datasource_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late TimetableLocalDataSource localDataSource;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    localDataSource =
        TimetableLocalDataSource(hive: mockHiveInterface);
  });

  test(
    'should return Timetable from Hive',
        () async {
      final Map<String, dynamic> tTimetableJson = fixture("timetable.json");
      final tTimetable = TimetableModel.fromJson(tTimetableJson);
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.toMap()).thenReturn(tTimetableJson);

      final result = await localDataSource.getTimetable();

      expect(result, tTimetable);
      verify(mockHiveInterface.openBox(any));
      verify(mockHiveBox.toMap());
      verifyNoMoreInteractions(mockHiveBox);
      verifyNoMoreInteractions(mockHiveInterface);
    },
  );

  test(
    'should set Timetable in Hive',
        () async {
      final tTimetable = getTestTimetableModel;
      final tTimetableJson = tTimetable.toJson();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.putAll(tTimetableJson)).thenAnswer((_) async => null);

      await localDataSource.setTimetable(tTimetable);

      verify(mockHiveInterface.openBox(any));
      verify(mockHiveBox.putAll(tTimetableJson));
      verifyNoMoreInteractions(mockHiveBox);
      verifyNoMoreInteractions(mockHiveInterface);
    },
  );
}