import 'package:pretend/data/models/subject_model.dart';
import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';

class TimetableWithSubjectsModel extends TimetableWithSubjects {
  const TimetableWithSubjectsModel(
    Timetable timetable,
    Map<String, Subject> subjects,
  ) : super(timetable, subjects);

  factory TimetableWithSubjectsModel.fromEntity(TimetableWithSubjects tws) {
    return TimetableWithSubjectsModel(tws.timetable, tws.subjects);
  }

  factory TimetableWithSubjectsModel.fromJson(Map<String, dynamic> json) {
    final timetable = TimetableModel.fromJson(json[keyTimetable]);
    final subjectsJson = Map<String, Map>.from(json[keySubjects]);
    final subjects = subjectsJson.map(
      (key, value) {
        final subjectJson = Map<String, dynamic>.from(value);
        return MapEntry(key, SubjectModel.fromJson(subjectJson));
      },
    );
    return TimetableWithSubjectsModel(timetable, subjects);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> tws = {};
    tws[keyTimetable] = TimetableModel.fromEntity(timetable).toJson();
    tws[keySubjects] = subjects.map((key, value) {
      final subjectJson = SubjectModel.fromEntity(value).toJson();
      return MapEntry(key, subjectJson);
    });
    return tws;
  }

  static const keySubjects = 'subjects';
  static const keyTimetable = 'timetable';
}
