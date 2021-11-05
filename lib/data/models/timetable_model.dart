import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/domain/entities/timetable.dart';

typedef TimetableJSONMap = Map<String, Map<String, dynamic>>;

class TimetableModel extends Timetable {
  TimetableModel(TimetableMap timetable, List<String> subjectCodes)
      : super(timetable, subjectCodes);

  factory TimetableModel.fromEntity(Timetable timetable) {
    return TimetableModel(timetable.timetable, timetable.subjectCodes);
  }

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    TimetableMap timetable = {};
    final timetableJson = json[KEY_TIMETABLE]!;
    for (String day in timetableJson.keys) {
      timetable[day] = {};
      for (String timeslot in timetableJson[day].keys) {
        timetable[day]![timeslot] =
            TimeslotModel.fromJson(timetableJson[day][timeslot]);
      }
    }
    final subjectCodes = (json[KEY_SUBJECTS] as List)
        .map((e) => e as String)
        .toList(growable: false);
    return TimetableModel(timetable, subjectCodes);
  }

  Map<String, dynamic> toJson() {
    TimetableJSONMap timetable = {};
    for (String day in this.timetable.keys) {
      timetable[day] = {};
      for (String timeslot in this.timetable[day]!.keys) {
        final entity = this.timetable[day]![timeslot]!;
        timetable[day]![timeslot] = TimeslotModel.fromEntity(entity).toJson();
      }
    }
    final timetableWithSubjects = {
      KEY_TIMETABLE: timetable,
      KEY_SUBJECTS: subjectCodes,
    };
    return timetableWithSubjects;
  }

  static const KEY_SUBJECTS = 'subjects';
  static const KEY_TIMETABLE = 'timetable';
}
