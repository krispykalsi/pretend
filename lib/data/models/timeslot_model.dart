import 'package:pretend/domain/entities/timeslot.dart';

class TimeslotModelFields {
  static const START = "start";
  static const END = "end";
  static const DURATION = "duration";
  static const CLASS_CATEGORY = "classCategory";
  static const SUBJECT_KEY = "subjectCode";
}

class TimeslotModel extends Timeslot {
  TimeslotModel({
    required String start,
    required String end,
    required int duration,
    required String classCategory,
    required String subjectCode,
  }) : super(
          start: start,
          end: end,
          duration: duration,
          classCategory: classCategory,
          subjectCode: subjectCode,
        );

  factory TimeslotModel.fromJson(Map<String, dynamic> json) {
    return TimeslotModel(
      start: json[TimeslotModelFields.START],
      end: json[TimeslotModelFields.END],
      duration: json[TimeslotModelFields.DURATION],
      classCategory: json[TimeslotModelFields.CLASS_CATEGORY],
      subjectCode: json[TimeslotModelFields.SUBJECT_KEY],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TimeslotModelFields.START: start,
      TimeslotModelFields.END: end,
      TimeslotModelFields.DURATION: duration,
      TimeslotModelFields.CLASS_CATEGORY: classCategory,
      TimeslotModelFields.SUBJECT_KEY: subjectCode,
    };
  }
}