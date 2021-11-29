import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';

import 'section_heading.dart';
import 'subject_list_tile.dart';

class LaterTodaySection extends StatelessWidget {
  final Map<Timeslots, Timeslot> laterToday;
  final Map<String, Subject> subjects;

  const LaterTodaySection({
    Key? key,
    required this.laterToday,
    required this.subjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading("Later today"),
        Expanded(
          child: FadedEdgeBox(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: laterToday.values.map<Widget>((timeslot) {
                final subject = subjects[timeslot.subjectCode] ??
                    const Subject("NOT FOUND", "NOT FOUND");
                return SubjectListTile(subject, timeslot);
              }).toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}
