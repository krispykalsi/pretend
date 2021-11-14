import 'package:equatable/equatable.dart';

class Timeslot extends Equatable {
  final String start;
  final String end;
  final int duration;
  final String classCategory;
  final String subjectCode;

  Timeslot({
    required this.start,
    required this.end,
    required this.duration,
    required this.classCategory,
    required this.subjectCode
  });

  @override
  List<Object?> get props => [start, end, subjectCode, classCategory];
}
