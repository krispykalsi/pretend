import 'package:flutter/foundation.dart';
import 'package:pretend/domain/entities/timeslot.dart';

class TimeslotModel extends Timeslot {
  @visibleForTesting
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

  factory TimeslotModel.fromEntity(Timeslot timeslot) {
    return TimeslotModel(
      start: timeslot.start,
      end: timeslot.end,
      duration: timeslot.duration,
      subjectCode: timeslot.subjectCode,
      classCategory: timeslot.classCategory,
    );
  }

  factory TimeslotModel.fromJson(Map<String, dynamic> json) {
    return TimeslotModel(
      start: json[KEY_START],
      end: json[KEY_END],
      duration: json[KEY_DURATION],
      classCategory: json[KEY_CLASS_CATEGORY],
      subjectCode: json[KEY_SUBJECT_CODE],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_START: start,
      KEY_END: end,
      KEY_DURATION: duration,
      KEY_CLASS_CATEGORY: classCategory,
      KEY_SUBJECT_CODE: subjectCode,
    };
  }

  static const KEY_START = "start";
  static const KEY_END = "end";
  static const KEY_DURATION = "duration";
  static const KEY_CLASS_CATEGORY = "classCategory";
  static const KEY_SUBJECT_CODE = "subjectCode";
}
