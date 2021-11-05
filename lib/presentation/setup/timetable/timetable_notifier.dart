import 'package:flutter/widgets.dart';

import 'typedefs.dart';

class TimetableNotifier extends ValueNotifier<SubjectWiseTimetable> {
  TimetableNotifier([SubjectWiseTimetable? timetable])
      : super(timetable == null ? SubjectWiseTimetable() : timetable);
}
