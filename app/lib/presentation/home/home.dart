import 'package:core/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/home/schedule_status/schedule_status_bloc.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:pretend/presentation/home/notification_button.dart';
import 'package:tap_canvas/tap_canvas.dart';

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
  final VoidCallback exportTimetable;

  late final _scheduleStatusBloc = sl<ScheduleStatusBloc>()
    ..add(GetStatusEvent(filteredSchedule));

  Home({
    Key? key,
    required this.timetable,
    required this.subjects,
    required this.filteredSchedule,
    required this.changeThemeColor,
    required this.editTimetable,
    required this.exportTimetable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapCanvas(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationButton(),
                CornerDateTime(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: BlocBuilder(
              bloc: _scheduleStatusBloc,
              builder: (context, state) {
                if (state is DoneForToday) {
                  return _happyPuu;
                } else if (state is NoClassToday) {
                  return _sleepingPuu;
                } else if (state is LastClassGoingOn || state is ClassesPending) {
                  return _normalState;
                }
                return SizedBox.shrink();
              },
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
              onExportTimetableTap: exportTimetable,
            ),
          )
        ],
      ),
    );
  }

  Widget get _normalState {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OngoingSection(
          schedule: filteredSchedule[Filters.onGoing]!,
          subjects: subjects,
        ),
        Expanded(
          child: _scheduleStatusBloc.state is LastClassGoingOn
              ? _readingPuu
              : LaterTodaySection(
                  schedule: filteredSchedule[Filters.laterToday]!,
                  subjects: subjects,
                ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget get _happyPuu =>
      const Center(child: Puu(Puus.happy, "All done for today! yay"));

  Widget get _readingPuu =>
      const Center(child: Puu(Puus.reading, "Last class for the day!!"));

  Widget get _sleepingPuu =>
      const Center(child: Puu(Puus.sleeping, "No class today. Wuhuu :D"));
}
