import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:core/widgets.dart';
import 'package:pretend/presentation/setup/timetable/selection_state_notifier.dart';

import 'typedefs.dart';
import 'timetable_setup.dart';

class TimetableSetupPage extends StatefulWidget {
  final Subject subject;
  final WeekSelectionState? selectionState;

  const TimetableSetupPage(
      {Key? key, required this.subject, this.selectionState})
      : super(key: key);

  @override
  _TimetableSetupPageState createState() => _TimetableSetupPageState();
}

class _TimetableSetupPageState extends State<TimetableSetupPage> {
  late final _selectionStateNotifier =
      SelectionStateNotifier(widget.selectionState);
  bool _isDonePressed = false;

  @override
  void dispose() {
    _selectionStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Configure Timetable",
      subtitle: "Subject: " + widget.subject.name,
      body: WillPopScope(
        onWillPop: () => _isDonePressed
            ? Future.value(true)
            : context.showConfirmationDialog(),
        child: Stack(
          children: [
            TimetableSetup(
              selectionStateNotifier: _selectionStateNotifier,
              onDone: () {
                _isDonePressed = true;
                context.router
                    .pop<WeekSelectionState>(_selectionStateNotifier.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
