import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/features/timetable/domain/entities/class_category_enum.dart';
import 'package:pretend/features/timetable/domain/entities/days_enum.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';
import 'package:pretend/features/timetable/domain/entities/time_set_enum.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/features/timetable/domain/usecases/get_timetable.dart';

import 'get_timetable_test.mocks.dart';

@GenerateMocks([TimetableRepositoryContract])
void main() {
  late GetTimetable usecase;
  late MockTimetableRepositoryContract mockRepository;

  setUp(() {
    mockRepository = MockTimetableRepositoryContract();
    usecase = GetTimetable(mockRepository);
  });

  final tDay = Days.MONDAY;
  final tTimetable = {
    TimeSets.T8AM: TimeSet(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T9AM: TimeSet(
      start: "8 AM",
      end: "10 AM",
      duration: 2,
      classCategory: ClassCategories.THEORY,
      subjectKey: "dsfFSFS3",
    ),
    TimeSets.T1PM: TimeSet(
      start: "1 PM",
      end: "2 PM",
      duration: 1,
      classCategory: ClassCategories.LAB,
      subjectKey: "fdsdfEv",
    ),
    TimeSets.T11AM: TimeSet(
      start: "11 AM",
      end: "12 PM",
      duration: 1,
      classCategory: ClassCategories.THEORY,
      subjectKey: "FHVBVsf356",
    ),
  };

  test('should get timetable from the repository', () async {
    when(mockRepository.getTimetable(tDay))
        .thenAnswer((_) async => Right(tTimetable));
    final result = await usecase(GetTimetableParams(tDay));
    expect(result, Right(tTimetable));
    verify(mockRepository.getTimetable(tDay));
    verifyNoMoreInteractions(mockRepository);
  });
}
