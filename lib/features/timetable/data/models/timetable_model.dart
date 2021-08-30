import 'package:pretend/features/timetable/data/models/time_set_model.dart';
import 'package:pretend/features/timetable/domain/entities/timetable.dart';

typedef TimetableModelMap = Map<String, Map<String, TimeSetModel>>;
typedef TimetableJSONMap = Map<String, Map<String, dynamic>>;

class TimetableModel extends Timetable {
  final TimetableModelMap timetable;

  TimetableModel(this.timetable) : super(timetable);

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    TimetableModelMap timetable = {};
    for (String day in json.keys) {
      timetable[day] = {};
      for (String timeSet in json[day]!.keys) {
        timetable[day]![timeSet] = TimeSetModel.fromJson(json[day]![timeSet]);
      }
    }
    return TimetableModel(timetable);
  }

  TimetableJSONMap toJson() {
    TimetableJSONMap timetable = {};
    for (String day in this.timetable.keys) {
      timetable[day] = {};
      for (String timeSet in this.timetable[day]!.keys) {
        timetable[day]![timeSet] = this.timetable[day]![timeSet]!.toJson();
      }
    }
    return timetable;
  }
}