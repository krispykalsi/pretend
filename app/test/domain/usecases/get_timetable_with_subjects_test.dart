import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

import '../../fixtures/timetable.dart';
import '../../fixtures/timetable_subjects.dart';
import 'get_timetable_with_subjects_test.mocks.dart';

@GenerateMocks([SubjectsRepositoryContract, TimetableRepositoryContract])
void main() {
  late GetTimetableWithSubjects usecase;
  late MockSubjectsRepositoryContract mockSubjectsRepo;
  late MockTimetableRepositoryContract mockTimetableRepo;

  setUp(() {
    mockSubjectsRepo = MockSubjectsRepositoryContract();
    mockTimetableRepo = MockTimetableRepositoryContract();
    usecase = GetTimetableWithSubjects(
      mockTimetableRepo,
      mockSubjectsRepo,
    );
  });

  final tTimetable = getTestTimetable;
  final tSubjects = getTestSubjectsOfTimetable;

  test('should correctly generate schedule for the given time', () async {
    when(mockTimetableRepo.getTimetable())
        .thenAnswer((_) async => Right(tTimetable));
    when(mockSubjectsRepo.getSubjectsFromKeys(tTimetable.subjectCodes))
        .thenAnswer((_) async => Right(tSubjects));
    final actual = await usecase(NoParams());
    final expected = Right(TimetableWithSubjects(
      tTimetable,
      tSubjects,
    ));
    expect(actual, expected);
    verify(mockTimetableRepo.getTimetable());
    verify(mockSubjectsRepo.getSubjectsFromKeys(tTimetable.subjectCodes));
    verifyNoMoreInteractions(mockTimetableRepo);
    verifyNoMoreInteractions(mockSubjectsRepo);
  });
}
