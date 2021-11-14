import 'package:core/error.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/domain/entities/timetable.dart';

typedef TimetableJSONMap = Map<String, Map<String, Map<String, dynamic>>>;

class TimetableModel extends Timetable {
  TimetableModel(TimetableMap timetable, List<String> subjectCodes)
      : super(timetable, subjectCodes);

  factory TimetableModel.fromEntity(Timetable timetable) {
    return TimetableModel(timetable.timetable, timetable.subjectCodes);
  }

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    if (json[KEY_TIMETABLE] == null) {
      throw NoLocalDataException();
    }
    TimetableMap timetable = {};
    final timetableJson = Map<String, Map>.from(json[KEY_TIMETABLE]);
    for (String day in timetableJson.keys) {
      timetable[day] = {};
      for (String timeslot in timetableJson[day]!.keys) {
        final timeslotJson =
            Map<String, dynamic>.from(timetableJson[day]![timeslot]);
        timetable[day]![timeslot] = TimeslotModel.fromJson(timeslotJson).toEntity();
      }
    }
    final subjectCodes = List<String>.from(json[KEY_SUBJECTS]);
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
