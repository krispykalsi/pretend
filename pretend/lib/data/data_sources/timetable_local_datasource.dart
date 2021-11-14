import 'package:hive/hive.dart';
import 'package:core/error.dart';
import 'package:pretend/data/models/timetable_model.dart';

import 'hive_datasource.dart';

abstract class TimetableLocalDataSourceContract {
  Future<TimetableModel> getTimetable();
  Future<void> setTimetable(TimetableModel timetable);
}

const _timetable = 'timetable';

class TimetableLocalDataSource extends HiveDataSource implements TimetableLocalDataSourceContract {
  TimetableLocalDataSource({required HiveInterface hive}) : super(hive);

  @override
  Future<TimetableModel> getTimetable() async {
    try {
      final timetableBox = await openBox(_timetable);
      return TimetableModel.fromJson(timetableBox.toMap().cast());
    } on NoLocalDataException {
      throw NoLocalDataException();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setTimetable(TimetableModel timetable) async {
    try {
      final timetableBox = await openBox(_timetable);
      await timetableBox.putAll(timetable.toJson());
    } catch (e) {
      throw CacheException();
    }
  }
}