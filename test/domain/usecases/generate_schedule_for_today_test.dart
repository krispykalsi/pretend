import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/extensions/date_time.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/generate_schedule_for_today.dart';

import '../../fixtures/filtered_schedule.dart';
import '../../fixtures/timetable.dart';
import '../../fixtures/timetable_subjects.dart';
import 'generate_schedule_for_today_test.mocks.dart';

@GenerateMocks([SubjectsRepositoryContract, TimetableRepositoryContract])
void main() {
  late GenerateScheduleForToday usecase;
  late MockSubjectsRepositoryContract mockSubjectsRepo;
  late MockTimetableRepositoryContract mockTimetableRepo;

  setUp(() {
    mockSubjectsRepo = MockSubjectsRepositoryContract();
    mockTimetableRepo = MockTimetableRepositoryContract();
    usecase = GenerateScheduleForToday(
      mockTimetableRepo,
      mockSubjectsRepo,
    );
  });

  final tTimetable = getTestTimetableModel;
  final tSubjects = getTestSubjectsOfTimetable;
  final tFilteredSchedule = getTestFilteredSchedule;

  final tDateTime = DateTime.now().update(
    hour: 11,
    minute: 5,
    day: DateTime.friday,
  );
  final tParams = GenerateScheduleForTodayParams(tDateTime);

  test('should correctly generate schedule for the given time', () async {
    when(mockTimetableRepo.getTimetable())
        .thenAnswer((_) async => Right(tTimetable));
    when(mockSubjectsRepo.getSubjectsFromKeys(tTimetable.subjectCodes))
        .thenAnswer((_) async => Right(tSubjects));
    final actual = await usecase(tParams);
    final expected = Right(GenerateScheduleForTodayOutput(
      tTimetable,
      tSubjects,
      tFilteredSchedule,
    ));
    expect(actual, expected);
    verify(mockTimetableRepo.getTimetable());
    verify(mockSubjectsRepo.getSubjectsFromKeys(tTimetable.subjectCodes));
    verifyNoMoreInteractions(mockTimetableRepo);
    verifyNoMoreInteractions(mockSubjectsRepo);
  });
}
