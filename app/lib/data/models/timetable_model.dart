import 'package:core/error.dart';
import 'package:pretend/data/models/timeslot_model.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

typedef TimetableJSONMap = Map<String, Map<String, Map<String, dynamic>>>;

class TimetableModel extends Timetable {
  const TimetableModel(TimetableMap timetable, List<String> subjectCodes)
      : super(timetable, subjectCodes);

  factory TimetableModel.fromEntity(Timetable timetable) {
    return TimetableModel(timetable.timetable, timetable.subjectCodes);
  }

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    if (json[keyTimetable] == null) {
      throw NoLocalDataException();
    }
    TimetableMap timetable = {};
    final timetableJson = Map<String, Map>.from(json[keyTimetable]);
    for (String day in timetableJson.keys) {
      timetable[day] = {};
      for (String slotDashed in timetableJson[day]!.keys) {
        final slot = getTimeslotFromDashed(slotDashed);
        final timeslotJson =
            Map<String, dynamic>.from(timetableJson[day]![slotDashed]);
        timetable[day]![slot] = TimeslotModel.fromJson(timeslotJson).toEntity();
      }
    }
    final subjectCodes = List<String>.from(json[keySubjects]);
    return TimetableModel(timetable, subjectCodes);
  }

  Map<String, dynamic> toJson() {
    TimetableJSONMap timetable = {};
    for (String day in this.timetable.keys) {
      timetable[day] = {};
      for (Timeslots timeslot in this.timetable[day]!.keys) {
        final entity = this.timetable[day]![timeslot]!;
        timetable[day]![timeslot.dashed] =
            TimeslotModel.fromEntity(entity).toJson();
      }
    }
    final timetableWithSubjects = {
      keyTimetable: timetable,
      keySubjects: subjectCodes,
    };
    return timetableWithSubjects;
  }

  static const keySubjects = 'subjects';
  static const keyTimetable = 'timetable';
}
