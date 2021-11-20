import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/injection_container.dart';
import 'package:core/widgets.dart';

import 'setup_subjects.dart';

class SetupSubjectsPage extends StatefulWidget {
  final List<Subject> _selectedSubjects;

  const SetupSubjectsPage({Key? key, List<Subject> selectedSubjects = const []})
      : _selectedSubjects = selectedSubjects,
        super(key: key);

  @override
  _SetupSubjectsPageState createState() => _SetupSubjectsPageState();
}

class _SetupSubjectsPageState extends State<SetupSubjectsPage> {
  late List<Subject> _selectedSubjects = widget._selectedSubjects;
  final _subjectsBloc = sl<SubjectsBloc>()..add(const GetAllSubjectsEvent());

  void _reloadSubjects() {
    _subjectsBloc.add(const GetAllSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select all your subjects",
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(_selectedSubjects);
          return false;
        },
        child: BlocBuilder<SubjectsBloc, SubjectsState>(
          bloc: _subjectsBloc,
          builder: (context, state) {
            if (state is Loaded) {
              return _buildLoadedState(state.subjects);
            } else if (state is OneOrMoreSubjectsSelected) {
              return _buildLoadedState(state.subjects);
            } else if (state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is Error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Cache Failure",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Text(state.msg),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: const Text("Retry"),
                      onPressed: _reloadSubjects,
                    ),
                  ],
                ),
              );
            } else if (state is NoSubjectsFound) {
              return _buildLoadedState([]);
            }
            return Center(
              child: ElevatedButton(
                child: const Text("Reload Subjects"),
                onPressed: _reloadSubjects,
              ),
            );
          },
        ),
      ),
    );
  }

  Stack _buildLoadedState(List<Subject> subs) {
    return Stack(
      children: [
        SetupSubjects(
          allSubjects: subs,
          previouslySelected: widget._selectedSubjects,
          onSubjectListUpdate: () {
            _subjectsBloc.add(const GetAllSubjectsEvent());
          },
          onSelectedSubjectsUpdate: (subjects) {
            _selectedSubjects = subjects;
            if (_selectedSubjects.isNotEmpty) {
              _subjectsBloc.add(const OneOrMoreSubjectsSelectedEvent());
            } else {
              _subjectsBloc.add(const NoSubjectsSelectedEvent());
            }
          },
        ),
        _buildNextButton
      ],
    );
  }

  Widget get _buildNextButton {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      bloc: _subjectsBloc,
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          right: state is OneOrMoreSubjectsSelected ? 0 : -100,
          bottom: 100,
          child: NextAccentButton(
            onTap: () => context.router.replace(
              TimetableSetupStatusRoute(subjects: _selectedSubjects),
            ),
          ),
        );
      },
    );
  }
}
