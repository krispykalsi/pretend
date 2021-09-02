import 'package:pretend/features/timetable/data/models/time_set_model.dart';
import 'package:pretend/features/timetable/domain/entities/timetable.dart';

typedef TimetableModelMap = Map<String, Map<String, TimeSetModel>>;
typedef TimetableJSONMap = Map<String, Map<String, dynamic>>;

class TimetableModel extends Timetable {
  final TimetableModelMap timetable;

  TimetableModel(this.timetable, List<String> subjectKeys)
      : super(timetable, subjectKeys);

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    TimetableModelMap timetable = {};
    final timetableJson = json[KEY_TIMETABLE]!;
    for (String day in timetableJson.keys) {
      timetable[day] = {};
      for (String timeSet in timetableJson[day].keys) {
        timetable[day]![timeSet] =
            TimeSetModel.fromJson(timetableJson[day][timeSet]);
      }
    }
    final subjectKeys = (json[KEY_SUBJECTS] as List)
        .map((e) => e as String)
        .toList(growable: false);
    return TimetableModel(timetable, subjectKeys);
  }

  Map<String, dynamic> toJson() {
    TimetableJSONMap timetable = {};
    for (String day in this.timetable.keys) {
      timetable[day] = {};
      for (String timeSet in this.timetable[day]!.keys) {
        timetable[day]![timeSet] = this.timetable[day]![timeSet]!.toJson();
      }
    }
    final timetableWithSubjects = {
      KEY_TIMETABLE: timetable,
      KEY_SUBJECTS: subjectKeys,
    };
    return timetableWithSubjects;
  }

  static const KEY_SUBJECTS = 'subjects';
  static const KEY_TIMETABLE = 'timetable';
}
