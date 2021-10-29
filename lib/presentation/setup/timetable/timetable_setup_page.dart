import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

import 'typedefs.dart';
import 'timetable_setup.dart';

class TimetableSetupPage extends StatefulWidget {
  const TimetableSetupPage({Key? key}) : super(key: key);

  @override
  _TimetableSetupPageState createState() => _TimetableSetupPageState();
}

class _TimetableSetupPageState extends State<TimetableSetupPage> {
  WeekSelectionState _timetable = WeekSelectionState();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Engineering Eco",
      subtitle: "tap on timeslots for this subject",
      body:
      Stack(
        children: [
          TimetableSetup(
            onTimetableUpdate: (updateTimetable) {
              _timetable = updateTimetable;
            },
            onDone: () => print(_timetable),
          ),
        ],
      ),

    );
  }
}
