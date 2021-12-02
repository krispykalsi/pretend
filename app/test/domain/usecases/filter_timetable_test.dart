import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/domain/usecases/filter_timetable.dart';
import 'package:core/extensions.dart';

import '../../fixtures/filtered_schedule.dart';
import '../../fixtures/timetable.dart';

void main() {
  late FilterTimetable usecase;

  setUp(() {
    usecase = FilterTimetable();
  });

  final tTimetable = getTestTimetable;
  final tFilteredSchedule = getTestFilteredSchedule;

  final tDateTime = DateTime.now().updateByWeekday(
    hour: 11,
    minute: 5,
    weekday: DateTime.friday,
  );
  final tParams = FilterTimetableParams(tDateTime, tTimetable);

  test('should correctly filter timetable to get schedule for right now',
      () async {
    final either = await usecase(tParams);
    either.fold(
      (failure) => fail("failed with failure: $failure"),
      (filteredSchedule) => expect(filteredSchedule, tFilteredSchedule),
    );
  });
}
