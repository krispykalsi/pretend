import 'package:equatable/equatable.dart';

typedef Timetable = Map<String, Map<int, TimeSet>>;

class TimeSet extends Equatable {
  final String start;
  final String end;
  final int duration;
  final String classCategory;
  final String subjectKey;

  TimeSet({
    required this.start,
    required this.end,
    required this.duration,
    required this.classCategory,
    required this.subjectKey
  });

  @override
  List<Object?> get props => [start, end, subjectKey, classCategory];
}
