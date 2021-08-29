import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/features/timetable/domain/usecases/get_subjects.dart';

import 'get_subjects_test.mocks.dart';


@GenerateMocks([TimetableRepository])
void main() {
  late GetSubjects usecase;
  late MockTimetableRepository mockTimetableRepository;

  setUp(() {
    mockTimetableRepository = MockTimetableRepository();
    usecase = GetSubjects(mockTimetableRepository);
  });

  final tDataSource = DataSource.LOCAL;
  final tSubjectList = [
    Subject("International Trade", "HU-351a"),
    Subject("Computer Networks", "IT-502"),
    Subject("Theory of Computing", "IT-504"),
  ];

  test('should get subject list from the repository', () async {
    when(mockTimetableRepository.getSubjects(tDataSource))
        .thenAnswer((_) async => Right(tSubjectList));
    final result = await usecase(Params(tDataSource));
    expect(result, Right(tSubjectList));
    verify(mockTimetableRepository.getSubjects(tDataSource));
    verifyNoMoreInteractions(mockTimetableRepository);
  });
}
