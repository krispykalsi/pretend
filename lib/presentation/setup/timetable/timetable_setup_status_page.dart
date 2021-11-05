import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/timetable/timetable_setup_bloc.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:pretend/presentation/common/accent_button.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';
import 'package:pretend/presentation/common/custom_dialog.dart';

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
  bool _shouldShowDoneButton = false;
  bool _savingTimetable = false;

  final _timetableSetupBloc = sl<TimetableSetupBloc>();

  @override
  void dispose() {
    _timetableNotifier.dispose();
    super.dispose();
  }

  void _onSetupStatusChanged() {
    var allSubjectsConfigured = true;
    widget._selectedSubjects.forEach((subject) {
      allSubjectsConfigured &= _timetableNotifier.value[subject.code] != null;
    });
    if (allSubjectsConfigured != _shouldShowDoneButton) {
      setState(() {
        _shouldShowDoneButton = allSubjectsConfigured;
        if (!(_timetableSetupBloc.state is TimetableSetupInitial) &&
            _shouldShowDoneButton == false) {
          _timetableSetupBloc.add(ResetSetupEvent());
        }
        _savingTimetable = false;
      });
    }
  }

  void _onDoneTap() {
    _timetableNotifier.value.forEach((subjectCode, selectionState) {
      _timetable.addSubject(subjectCode, selectionState);
    });

    _timetableSetupBloc.add(SaveTimetableEvent(timetable: _timetable));
    setState(() => _savingTimetable = true);
  }

  void _onBackTap() async {
    var shouldGoBack = await context.showConfirmationDialog();
    if (shouldGoBack) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Timetable",
      subtitle: "configure timetable for your subjects",
      body: WillPopScope(
        onWillPop: () => context.showConfirmationDialog(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimetableSetupStatus(
                    onSetupStatusChanged: _onSetupStatusChanged,
                    subjects: widget._selectedSubjects,
                    notifier: _timetableNotifier,
                  ),
                  SizedBox(height: 10),
                  _buildHelperMessage,
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: !_savingTimetable ? 0 : -100,
              bottom: 100,
              child: BackAccentButton(onTap: _onBackTap),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              right: _shouldShowDoneButton && !_savingTimetable ? 0 : -100,
              bottom: 100,
              child: DoneAccentButton(onTap: _onDoneTap),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildHelperMessage {
    return BlocBuilder(
      bloc: _timetableSetupBloc,
      builder: (context, state) {
        if (state is TimetableSetupInitial) {
          if (_shouldShowDoneButton) {
            return Text("All done! Tap done to continue");
          } else {
            return Text("Tap on a subject to configure");
          }
        } else if (state is TimetableSaving) {
          return CircularProgressIndicator();
        } else if (state is TimetableSaved) {
          return Text(
            "Timetable saved successfully",
            style: TextStyle(color: Colors.lightGreen),
          );
        } else if (state is TimetableNotSavedError) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            setState(() {
              _savingTimetable = false;
            });
          });
          return Text(
            state.message,
            style: TextStyle(color: Colors.redAccent),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
