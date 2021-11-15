import 'package:flutter/foundation.dart';
import 'package:pretend/domain/entities/timeslot.dart';

class TimeslotModel extends Timeslot {
  @visibleForTesting
  const TimeslotModel({
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
      start: json[keyStart],
      end: json[keyEnd],
      duration: json[keyDuration],
      classCategory: json[keyClassCategory],
      subjectCode: json[keySubjectCode],
    );
  }

  Timeslot toEntity() {
    return Timeslot(
      start: start,
      end: end,
      duration: duration,
      subjectCode: subjectCode,
      classCategory: classCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyStart: start,
      keyEnd: end,
      keyDuration: duration,
      keyClassCategory: classCategory,
      keySubjectCode: subjectCode,
    };
  }

  static const keyStart = "start";
  static const keyEnd = "end";
  static const keyDuration = "duration";
  static const keyClassCategory = "classCategory";
  static const keySubjectCode = "subjectCode";
}
