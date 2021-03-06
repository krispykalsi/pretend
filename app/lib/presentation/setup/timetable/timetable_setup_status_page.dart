import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/timetable/timetable_setup_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:core/widgets.dart';
import 'package:core/app_colors.dart';
import 'package:auto_route/auto_route.dart';

import 'timetable_notifier.dart';
import 'timetable_setup_status.dart';
import 'timetable_extensions.dart';

class TimetableSetupStatusPage extends StatefulWidget {
  final List<Subject> _selectedSubjects;
  final Timetable? _timetable;
  final bool _canGoBack;

  const TimetableSetupStatusPage({
    Key? key,
    Timetable? timetable,
    bool canGoBack = true,
    required List<Subject> subjects,
  })  : _selectedSubjects = subjects,
        _timetable = timetable,
        _canGoBack = canGoBack,
        super(key: key);
/**/
  @override
  State<TimetableSetupStatusPage> createState() =>
      _TimetableSetupStatusPageState();
}

class _TimetableSetupStatusPageState extends State<TimetableSetupStatusPage> {
  late final _timetableNotifier =
      TimetableNotifier(widget._timetable?.subjectWise());
  late final _timetable = Timetable({}, [])..update(_timetableNotifier.value);

  final _timetableSetupBloc = sl<TimetableSetupBloc>();

  @override
  void initState() {
    super.initState();
    _checkIfAllSubjectsConfigured();
  }

  @override
  void dispose() {
    _timetableNotifier.dispose();
    super.dispose();
  }

  void _checkIfAllSubjectsConfigured() {
    var allSubjectsConfigured = true;
    for (var subject in widget._selectedSubjects) {
      allSubjectsConfigured &= _timetableNotifier.value[subject.code] != null;
    }
    if (allSubjectsConfigured == true && widget._selectedSubjects.isNotEmpty) {
      _timetableSetupBloc.add(const AllSubjectsConfiguredEvent());
    } else {
      _timetableSetupBloc.add(const ResetSetupEvent());
    }
  }

  void _onContinueTap() {
    context.router.pushAndPopUntil(
      const HomeRoute(),
      predicate: (_) => false,
    );
  }

  void _onDoneTap() {
    _timetable.update(_timetableNotifier.value);
    _timetableSetupBloc.add(SaveTimetableEvent(timetable: _timetable));
  }

  void _onBackTap() async {
    context.router.pop();
  }

  void _addOrRemoveSubjectsTap() async {
    context.router.replace(SetupSubjectsRoute(
      selectedSubjects: widget._selectedSubjects,
      timetable: _timetable
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Timetable",
      subtitle: "configure timetable for your subjects",
      body: WillPopScope(
        onWillPop: () => widget._canGoBack
            ? context.showConfirmationDialog()
            : Future.value(false),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHelperMessage,
                  const SizedBox(height: 40),
                  TimetableSetupStatus(
                    onSetupStatusChanged: _checkIfAllSubjectsConfigured,
                    subjects: widget._selectedSubjects,
                    notifier: _timetableNotifier,
                  ),
                  _buildAddRemoveSubjectsButton,
                ],
              ),
            ),
            widget._canGoBack ? _buildBackButton : SizedBox(),
            _buildDoneOrContinueButton,
          ],
        ),
      ),
    );
  }

  Widget get _buildAddRemoveSubjectsButton {
    return BlocBuilder<TimetableSetupBloc, TimetableSetupState>(
      bloc: _timetableSetupBloc,
      builder: (context, state) {
        bool _visible = true;
        if (state is TimetableSaving || state is TimetableSaved) {
          _visible = false;
        }
        return AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: TextButton(
            onPressed: _addOrRemoveSubjectsTap,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
              foregroundColor: MaterialStateProperty.all(AppColors.accent),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.library_books),
                SizedBox(width: 10),
                Text("Add/remove subjects"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _buildDoneOrContinueButton {
    return BlocBuilder<TimetableSetupBloc, TimetableSetupState>(
      bloc: _timetableSetupBloc,
      builder: (context, state) {
        bool _continue = false;
        bool _done = false;
        if (state is AllSubjectsConfigured || state is TimetableNotSavedError) {
          _done = true;
        } else if (state is TimetableSaved) {
          _continue = true;
        }
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              right: _done ? 0 : -150,
              bottom: 100,
              child: DoneAccentButton(onTap: _onDoneTap),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              right: _continue ? 0 : -150,
              bottom: 100,
              child: ContinueAccentButton(onTap: _onContinueTap),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildBackButton {
    return BlocBuilder<TimetableSetupBloc, TimetableSetupState>(
      bloc: _timetableSetupBloc,
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: state is TimetableSaving ? -100 : 0,
          bottom: 100,
          child: BackAccentButton(onTap: _onBackTap),
        );
      },
    );
  }

  Widget get _buildHelperMessage {
    return BlocBuilder<TimetableSetupBloc, TimetableSetupState>(
      bloc: _timetableSetupBloc,
      builder: (context, state) {
        if (state is TimetableSetupInitial) {
          return widget._selectedSubjects.isEmpty
              ? const SizedBox.shrink()
              : const Text("Tap on a subject to configure");
        } else if (state is AllSubjectsConfigured) {
          return const Text("All done! Tap done to continue");
        } else if (state is TimetableSaving) {
          return const CircularProgressIndicator();
        } else if (state is TimetableSaved) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Timetable saved successfully",
                style: TextStyle(color: Colors.lightGreen),
              ),
              Text("Tap continue")
            ],
          );
        } else if (state is TimetableNotSavedError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Failed to save",
                style: const TextStyle(color: Colors.redAccent),
              ),
              Text(state.message),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
