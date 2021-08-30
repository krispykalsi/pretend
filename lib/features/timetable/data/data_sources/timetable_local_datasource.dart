import 'package:pretend/features/timetable/domain/entities/timetable.dart';

abstract class TimetableLocalDataSourceContract {
  Future<Timetable> getTimetable();
  Future<void> setTimetable(Timetable timetable);
}
