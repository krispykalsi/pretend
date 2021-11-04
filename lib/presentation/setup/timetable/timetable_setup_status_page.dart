import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/presentation/common/button_next.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

import 'timetable_notifier.dart';
import 'timetable_setup_status.dart';
import 'timetable_extensions.dart';

class TimetableSetupStatusPage extends StatefulWidget {
  final List<Subject> _selectedSubjects;

  TimetableSetupStatusPage({Key? key, required List<Subject> subjects})
      : _selectedSubjects = subjects,
        super(key: key);

  @override
  State<TimetableSetupStatusPage> createState() =>
      _TimetableSetupStatusPageState();
}

class _TimetableSetupStatusPageState extends State<TimetableSetupStatusPage> {
  final _timetableNotifier = TimetableNotifier();
  final _timetable = Timetable(TimetableMap(), []);
  bool _showNextButton = false;

  @override
  void dispose() {
    _timetableNotifier.dispose();
    super.dispose();
  }

  void _onSetupStatusChanged() {
    var shouldShowNextButton = true;
    widget._selectedSubjects.forEach((subject) {
      shouldShowNextButton &= _timetableNotifier.value[subject.code] != null;
    });
    if (shouldShowNextButton != _showNextButton) {
      setState(() {
        _showNextButton = shouldShowNextButton;
      });
    }
  }

  void _onNextTap() {
    _timetableNotifier.value.forEach((subjectCode, selectionState) {
      _timetable.addSubject(subjectCode, selectionState);
    });
    print(_timetable);
    print(_timetable.subjectCodes);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Timetable",
      subtitle: "configure timetable for your subjects",
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.5),
            child: TimetableSetupStatus(
              onSetupStatusChanged: _onSetupStatusChanged,
              subjects: widget._selectedSubjects,
              notifier: _timetableNotifier,
            ),
          ),
          _showNextButton
              ? Positioned(
                  right: 0,
                  bottom: 100,
                  child: ButtonNext(onTap: _onNextTap),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
