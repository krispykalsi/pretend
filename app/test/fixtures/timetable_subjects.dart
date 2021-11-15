import 'package:pretend/domain/entities/subject.dart';

final _subjectsOfTimetable = {
  "HU-351a": const Subject("International Trade", "HU-351a"),
  "IT-502": const Subject("Computer Networks", "IT-502"),
  "IT-504": const Subject("Theory of Computing", "IT-504")
};

Map<String, Subject> get getTestSubjectsOfTimetable => _subjectsOfTimetable;