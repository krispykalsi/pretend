import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/set_timetable.dart';
import 'package:pretend/domain/usecases/toggle_notifications.dart';

import '../../fixtures/timetable.dart';
import 'set_timetable_test.mocks.dart';

@GenerateMocks([TimetableRepositoryContract, ToggleNotifications])
void main() {
  late SetTimetable usecase;
  late MockTimetableRepositoryContract mockRepository;
  late MockToggleNotifications mockToggleNotifications;
  setUp(() {
    mockRepository = MockTimetableRepositoryContract();
    mockToggleNotifications = MockToggleNotifications();
    usecase = SetTimetable(mockRepository, mockToggleNotifications);
  });

  final tTimetable = getTestTimetableModel;

  test(
    'should set timetable using the repository and refresh notification schedules',
    () async {
      when(mockRepository.setTimetable(any))
          .thenAnswer((_) async => const Right(null));
      when(mockToggleNotifications.call(any))
          .thenAnswer((_) async => const Right(null));
      await usecase(SetTimetableParams(tTimetable));

      verify(mockRepository.setTimetable(tTimetable));
      verify(mockToggleNotifications
          .call(ToggleNotificationsParams(Notifications.REFRESH)));
      verifyNoMoreInteractions(mockRepository);
      verifyNoMoreInteractions(mockToggleNotifications);
    },
  );
}
