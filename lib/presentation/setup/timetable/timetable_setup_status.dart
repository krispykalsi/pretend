import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

import 'subject_list_tile.dart';

class TimetableSetupStatus extends StatelessWidget {
  const TimetableSetupStatus({
    Key? key,
    required List<Subject> subjects,
  })  : _subjects = subjects,
        super(key: key);

  final List<Subject> _subjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(_subjects.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: SubjectListTile(
              onTap: () {},
              isConfigured: true,
              subject: _subjects[index],
            ),
          ),
        );
      }),
    );
  }
}
