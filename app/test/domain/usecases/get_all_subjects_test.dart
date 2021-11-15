import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/network.dart';
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

  const tDataSource = DataSource.LOCAL;
  final tSubjectList = [
    const Subject("International Trade", "HU-351a"),
    const Subject("Computer Networks", "IT-502"),
    const Subject("Theory of Computing", "IT-504"),
  ];

  test('should get subject list from the repository', () async {
    when(mockSubjectsRepository.getSubjects(tDataSource))
        .thenAnswer((_) async => Right(tSubjectList));
    final result = await usecase(const GetAllSubjectsParams(tDataSource));
    expect(result, Right(tSubjectList));
    verify(mockSubjectsRepository.getSubjects(tDataSource));
    verifyNoMoreInteractions(mockSubjectsRepository);
  });
}
