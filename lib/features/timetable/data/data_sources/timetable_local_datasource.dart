import 'package:pretend/features/timetable/domain/entities/time_set.dart';

abstract class TimetableLocalDataSourceContract {
  Future<Timetable> getTimetable();
  Future<void> setTimetable(Timetable timetable);
}
