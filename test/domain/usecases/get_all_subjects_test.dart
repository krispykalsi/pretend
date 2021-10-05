import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/usecases/get_all_subjects.dart';

import 'get_all_subjects_test.mocks.dart';


@GenerateMocks([SubjectsRepositoryContract])
void main() {
  late GetAllSubjects usecase;
  late MockSubjectsRepositoryContract mockSubjectsRepository;

  setUp(() {
    mockSubjectsRepository = MockSubjectsRepositoryContract();
    usecase = GetAllSubjects(mockSubjectsRepository);
  });

  final tDataSource = DataSource.LOCAL;
  final tSubjectList = [
    Subject("International Trade", "HU-351a"),
    Subject("Computer Networks", "IT-502"),
    Subject("Theory of Computing", "IT-504"),
  ];

  test('should get subject list from the repository', () async {
    when(mockSubjectsRepository.getSubjects(tDataSource))
        .thenAnswer((_) async => Right(tSubjectList));
    final result = await usecase(GetAllSubjectsParams(tDataSource));
    expect(result, Right(tSubjectList));
    verify(mockSubjectsRepository.getSubjects(tDataSource));
    verifyNoMoreInteractions(mockSubjectsRepository);
  });
}
