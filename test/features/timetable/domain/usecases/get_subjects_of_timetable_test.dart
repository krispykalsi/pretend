import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';
import 'package:pretend/features/timetable/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/features/timetable/domain/usecases/get_subjects_of_timetable.dart';

import 'get_subjects_of_timetable_test.mocks.dart';

@GenerateMocks([SubjectsRepositoryContract])
void main() {
  late GetSubjectsOfTimetable usecase;
  late MockSubjectsRepositoryContract repository;

  setUp(() {
    repository = MockSubjectsRepositoryContract();
    usecase = GetSubjectsOfTimetable(repository);
  });

  final tSubjectKeys = ["dsfFSFS3", "fdsdfEv", "FHVBVsf356"];
  final tSubjectMap = {
    "dsfFSFS3": Subject("International Trade", "HU-351a"),
    "fdsdfEv": Subject("Computer Networks", "IT-502"),
    "FHVBVsf356": Subject("Theory of Computing", "IT-504")
  };

  test(
    'should get map of subjects from a list of subjectKeys of the timetable from the repository',
    () async {
      when(repository.getSubjectsFromKeys(tSubjectKeys))
          .thenAnswer((_) async => Right(tSubjectMap));
      final result = await usecase(GetSubjectsOfTimetableParams(tSubjectKeys));
      expect(result, Right(tSubjectMap));
      verify(repository.getSubjectsFromKeys(tSubjectKeys));
      verifyNoMoreInteractions(repository);
    },
  );
}
