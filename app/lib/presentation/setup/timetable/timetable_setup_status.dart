import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/setup/timetable/timetable_notifier.dart';

import 'subject_list_tile.dart';
import 'typedefs.dart';

class TimetableSetupStatus extends StatefulWidget {
  const TimetableSetupStatus({
    Key? key,
    required VoidCallback onSetupStatusChanged,
    required List<Subject> subjects,
    required TimetableNotifier notifier,
  })  : _subjects = subjects,
        _timetableNotifier = notifier,
        _onReturnFromTimetableSetup = onSetupStatusChanged,
        super(key: key);

  final List<Subject> _subjects;
  final TimetableNotifier _timetableNotifier;
  final VoidCallback? _onReturnFromTimetableSetup;

  @override
  State<TimetableSetupStatus> createState() => _TimetableSetupStatusState();
}

class _TimetableSetupStatusState extends State<TimetableSetupStatus> {
  final _isConfigured = Map<String, bool>();

  void _onSubjectTap(int index) async {
    final subject = widget._subjects[index];
    final selectionState = await context.router.push(TimetableSetupRoute(
      selectionState: widget._timetableNotifier.value[subject.code],
      subject: subject,
    )) as WeekSelectionState?;

    if (selectionState != null) {
      widget._timetableNotifier.value[subject.code] = selectionState;
    } else {
      widget._timetableNotifier.value.remove(subject.code);
    }

    widget._onReturnFromTimetableSetup?.call();

    setState(() {
      _isConfigured[subject.code] = selectionState != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(widget._subjects.length, (index) {
        final subject = widget._subjects[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: SubjectListTile(
              onTap: () => _onSubjectTap(index),
              isConfigured: _isConfigured[subject.code] ?? false,
              subject: subject,
            ),
          ),
        );
      }),
    );
  }
}
