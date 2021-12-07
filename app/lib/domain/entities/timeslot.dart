import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timeslots.dart';

class Timeslot extends Equatable implements Comparable<Timeslot> {
  final Timeslots slot;
  final String classCategory;
  final String subjectCode;

  const Timeslot({
    required this.slot,
    required this.classCategory,
    required this.subjectCode,
  });

  String get start => slot.startHour12;

  String get end => slot.endHour12;

  @override
  List<Object?> get props => [slot, subjectCode, classCategory];

  @override
  int compareTo(other) => slot.compareTo(other.slot);
}
