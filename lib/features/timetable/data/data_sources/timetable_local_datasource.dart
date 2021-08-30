import 'package:hive/hive.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/features/timetable/data/models/timetable_model.dart';

import 'hive_datasource.dart';

abstract class TimetableLocalDataSourceContract {
  Future<TimetableModel> getTimetable();
  Future<void> setTimetable(TimetableModel timetable);
}

const _TIMETABLE = 'timetable';

class TimetableLocalDataSource extends HiveDataSource implements TimetableLocalDataSourceContract {
  TimetableLocalDataSource({required HiveInterface hive}) : super(hive);

  @override
  Future<TimetableModel> getTimetable() async {
    try {
      final subjectBox = await openBox(_TIMETABLE);
      return TimetableModel.fromJson(subjectBox.toMap().cast());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setTimetable(TimetableModel timetable) async {
    try {
      final subjectBox = await openBox(_TIMETABLE);
      await subjectBox.putAll(timetable.toJson());
    } catch (e) {
      throw CacheException();
    }
  }
}