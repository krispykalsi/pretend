import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/features/timetable/domain/usecases/set_timetable.dart';

import '../../../../fixtures/timetable.dart';
import 'set_timetable_test.mocks.dart';

@GenerateMocks([TimetableRepositoryContract])
void main() {
  late SetTimetable usecase;
  late MockTimetableRepositoryContract mockRepository;

  setUp(() {
    mockRepository = MockTimetableRepositoryContract();
    usecase = SetTimetable(mockRepository);
  });

  final tTimetable = getTestTimetableModel;

  test('should set timetable using the repository', () async {
    when(mockRepository.setTimetable(tTimetable))
        .thenAnswer((_) async => Right(null));
    await usecase(SetTimetableParams(tTimetable));

    verify(mockRepository.setTimetable(tTimetable));
    verifyNoMoreInteractions(mockRepository);
  });
}
