import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:core/extensions.dart';
import 'package:pretend/domain/entities/filters.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:core/app_colors.dart';
import 'package:auto_route/auto_route.dart';

import 'settings_section.dart';
import 'subject_list_tile.dart';
import 'corner_date_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = sl<HomeBloc>()
    ..add(GetTimetableEvent(DateTime.now().update(
      hour: 11,
      minute: 5,
      day: DateTime.friday,
    )));
  late Map<String, Subject> _subjects;

  void _editTimetable(Timetable timetable) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.router.push(
        TimetableSetupStatusRoute(
          subjects: _subjects.values.toList(growable: false),
          timetable: timetable,
        ),
      );
    });
  }

  void _changeThemeColor() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.router.push(ThemeSetupRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.DARK,
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is TimetableLoaded) {
            _subjects = state.subjects;
            return _buildLoadedState(state);
          } else if (state is TimetableLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TimetableNotFound) {
            context.router
                .replace(TimetableSetupStatusRoute(subjects: const []));
          } else if (state is TimetableError) {
            return Text(
              state.message,
              style: const TextStyle(color: Colors.redAccent),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedState(TimetableLoaded state) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: CornerDateTime(),
        ),
        Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildOngoingSection(state.filteredSchedule[Filters.onGoing]!),
              const SizedBox(height: 50),
              Expanded(
                child: _buildLaterTodaySection(
                    state.filteredSchedule[Filters.laterToday]!),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SettingsSection(
            onThemeChangeTap: _changeThemeColor,
            onTimetableEditTap: () => _editTimetable(state.timetable),
          ),
        )
      ],
    );
  }

  Widget _buildLaterTodaySection(Map<Timeslots, Timeslot> laterToday) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading("Later today"),
        Expanded(
          child: FadedEdgeBox(
            child: ListView(
              children: laterToday.values.map<Widget>((timeslot) {
                final subject = _subjects[timeslot.subjectCode] ??
                    const Subject("NOT FOUND", "NOT FOUND");
                return SubjectListTile(subject, timeslot);
              }).toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOngoingSection(Map<Timeslots, Timeslot> onGoing) {
    late Timeslot timeslot;
    late Subject subject;
    if (onGoing.isNotEmpty) {
      timeslot = onGoing.values.elementAt(0);
      subject = _subjects[timeslot.subjectCode] ??
          const Subject("NOT FOUND", "NOT FOUND");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading("Ongoing"),
        const SizedBox(height: 10),
        onGoing.isNotEmpty
            ? SubjectListTile(
                subject,
                timeslot,
                isOnGoing: true,
              )
            : const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("Nothing to see here!"),
              ),
      ],
    );
  }

  Text _buildSectionHeading(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
