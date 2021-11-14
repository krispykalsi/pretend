import 'package:pretend/domain/entities/subject.dart';

final _subjectsOfTimetable = {
  "HU-351a": Subject("International Trade", "HU-351a"),
  "IT-502": Subject("Computer Networks", "IT-502"),
  "IT-504": Subject("Theory of Computing", "IT-504")
};

Map<String, Subject> get getTestSubjectsOfTimetable => _subjectsOfTimetable;