import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:auto_route/auto_route.dart';

import 'subject_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = sl<HomeBloc>()..add(GetTimetableEvent());
  late Map<String, Timeslot> _timetableForToday;
  late Map<String, Subject> _subjects;

  void _onEditPressed(Timetable timetable) {
    context.router.push(
      TimetableSetupStatusRoute(
        subjects: _subjects.values.toList(growable: false),
        timetable: timetable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.DARK,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is TimetableLoaded) {
              _timetableForToday = state.timetable.timetable[Days.MONDAY] ?? {};
              _subjects = state.subjects;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => _onEditPressed(state.timetable),
                    child: Text("Edit"),
                  ),
                  _buildOngoingSection(),
                  SizedBox(height: 50),
                  _buildLaterTodaySection(),
                ],
              );
            } else if (state is TimetableLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TimetableError) {
              return Text(
                state.message,
                style: TextStyle(color: Colors.redAccent),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLaterTodaySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeading("Later today"),
          Expanded(
            // child: ListView.builder(
            //   clipBehavior: Clip.none,
            //   itemBuilder: (context, idx) {
            //     return SubjectListTile(
            //       subject: tSubject,
            //       timeslot: tTimeslot,
            //     );
            //   },
            //   itemCount: _timetable.keys.length,
            // ),
            child: ListView(
              children: _timetableForToday.entries.map<Widget>((entry) {
                final timeslot = entry.value;
                final subject = _subjects[timeslot.subjectCode] ??
                    Subject("NOT FOUND", "NOT FOUND");
                return SubjectListTile(subject, timeslot);
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingSection() {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     _buildSectionHeading("Ongoing"),
    //     SizedBox(height: 10),
    //     SubjectListTile(
    //       subject: tSubject,
    //       timeslot: tTimeslot,
    //       isOnGoing: true,
    //     ),
    //   ],
    // );
    return SizedBox.shrink();
  }

  Text _buildSectionHeading(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
