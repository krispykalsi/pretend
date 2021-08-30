import 'package:pretend/features/timetable/domain/entities/time_set.dart';

class TimeSetModelFields {
  static const START = "start";
  static const END = "end";
  static const DURATION = "duration";
  static const CLASS_CATEGORY = "classCategory";
  static const SUBJECT_KEY = "subjectKey";
}

class TimeSetModel extends TimeSet {
  TimeSetModel({
    required String start,
    required String end,
    required int duration,
    required String classCategory,
    required String subjectKey,
  }) : super(
          start: start,
          end: end,
          duration: duration,
          classCategory: classCategory,
          subjectKey: subjectKey,
        );

  factory TimeSetModel.fromJson(Map<String, dynamic> json) {
    return TimeSetModel(
      start: json[TimeSetModelFields.START],
      end: json[TimeSetModelFields.END],
      duration: json[TimeSetModelFields.DURATION],
      classCategory: json[TimeSetModelFields.CLASS_CATEGORY],
      subjectKey: json[TimeSetModelFields.SUBJECT_KEY],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TimeSetModelFields.START: start,
      TimeSetModelFields.END: end,
      TimeSetModelFields.DURATION: duration,
      TimeSetModelFields.CLASS_CATEGORY: classCategory,
      TimeSetModelFields.SUBJECT_KEY: subjectKey,
    };
  }
}
