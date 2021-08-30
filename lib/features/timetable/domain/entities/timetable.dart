import 'package:equatable/equatable.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';

typedef TimetableMap = Map<String, Map<String, TimeSet>>;

class Timetable extends Equatable {
  final TimetableMap timetable;

  Timetable(this.timetable);

  @override
  List<Object?> get props => [timetable];
}