import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/get_timetable.dart';

import '../../fixtures/timetable.dart';
import 'get_timetable_test.mocks.dart';

@GenerateMocks([TimetableRepositoryContract])
void main() {
  late GetTimetable usecase;
  late MockTimetableRepositoryContract mockRepository;

  setUp(() {
    mockRepository = MockTimetableRepositoryContract();
    usecase = GetTimetable(mockRepository);
  });

  final tTimetable = getTestTimetableModel;

  test('should get timetable from the repository', () async {
    when(mockRepository.getTimetable())
        .thenAnswer((_) async => Right(tTimetable));
    final result = await usecase(NoParams());
    expect(result, Right(tTimetable));
    verify(mockRepository.getTimetable());
    verifyNoMoreInteractions(mockRepository);
  });
}
