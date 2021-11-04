import 'package:flutter/widgets.dart';

import 'typedefs.dart';

class TimetableNotifier extends ValueNotifier<SubjectWiseTimetable> {
  TimetableNotifier() : super(SubjectWiseTimetable());
}