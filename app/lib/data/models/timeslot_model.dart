import 'package:flutter/foundation.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';

class TimeslotModel extends Timeslot {
  @visibleForTesting
  const TimeslotModel({
    required Timeslots slot,
    required String classCategory,
    required String subjectCode,
  }) : super(
          slot: slot,
          classCategory: classCategory,
          subjectCode: subjectCode,
        );

  factory TimeslotModel.fromEntity(Timeslot timeslot) {
    return TimeslotModel(
      slot: timeslot.slot,
      subjectCode: timeslot.subjectCode,
      classCategory: timeslot.classCategory,
    );
  }

  factory TimeslotModel.fromJson(Map<String, dynamic> json) {
    return TimeslotModel(
      slot: getTimeslotFromDashed(json[keySlot]),
      classCategory: json[keyClassCategory],
      subjectCode: json[keySubjectCode],
    );
  }

  Timeslot toEntity() {
    return Timeslot(
      slot: slot,
      subjectCode: subjectCode,
      classCategory: classCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keySlot: slot.dashed,
      keyClassCategory: classCategory,
      keySubjectCode: subjectCode,
    };
  }

  static const keySlot = "slot";
  static const keyClassCategory = "classCategory";
  static const keySubjectCode = "subjectCode";
}
