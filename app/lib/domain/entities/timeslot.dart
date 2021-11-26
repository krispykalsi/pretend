import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timeslots.dart';

class Timeslot extends Equatable {
  final Timeslots slot;
  final String classCategory;
  final String subjectCode;

  const Timeslot({
    required this.slot,
    required this.classCategory,
    required this.subjectCode,
  });

  String get start => slot.start;

  String get end => slot.end;

  @override
  List<Object?> get props => [slot, subjectCode, classCategory];
}
