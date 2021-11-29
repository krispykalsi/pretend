import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';

import 'corner_date_time.dart';
import 'later_today_section.dart';
import 'ongoing_section.dart';
import 'settings_section.dart';

class Home extends StatelessWidget {
  final Timetable timetable;
  final Map<String, Subject> subjects;
  final Map<Filters, Map<Timeslots, Timeslot>> filteredSchedule;
  final VoidCallback changeThemeColor;
  final Function(Timetable, List<Subject>) editTimetable;

  const Home({
    Key? key,
    required this.timetable,
    required this.subjects,
    required this.filteredSchedule,
    required this.changeThemeColor,
    required this.editTimetable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: CornerDateTime(),
        ),
        Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OngoingSection(
                onGoing: filteredSchedule[Filters.onGoing]!,
                subjects: subjects,
              ),
              Expanded(
                child: LaterTodaySection(
                  laterToday: filteredSchedule[Filters.laterToday]!,
                  subjects: subjects,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SettingsSection(
            onThemeChangeTap: changeThemeColor,
            onTimetableEditTap: () => editTimetable(
              timetable,
              subjects.values.toList(growable: false),
            ),
          ),
        )
      ],
    );
  }
}
