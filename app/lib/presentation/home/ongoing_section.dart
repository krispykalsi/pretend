import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/presentation/home/section_heading.dart';

import 'subject_list_tile.dart';

class OngoingSection extends StatelessWidget {
  final Map<Timeslots, Timeslot> onGoing;
  final Map<String, Subject> subjects;

  const OngoingSection({
    Key? key,
    required this.onGoing,
    required this.subjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Timeslot timeslot;
    late Subject subject;
    if (onGoing.isNotEmpty) {
      timeslot = onGoing.values.elementAt(0);
      subject = subjects[timeslot.subjectCode] ??
          const Subject("NOT FOUND", "NOT FOUND");
    } else {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading("Ongoing"),
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
        const SizedBox(height: 50),
      ],
    );
  }
}
