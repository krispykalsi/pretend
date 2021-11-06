import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/injection_container.dart';
import 'package:pretend/presentation/common/accent_button.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

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
              return CircularProgressIndicator();
            } else if (state is Error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Cache Failure",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Text(state.msg),
                  ],
                ),
              );
            }
            return Center(
              child: ElevatedButton(
                child: Text("load subs"),
                onPressed: () {
                  _subjectsBloc.add(const GetAllSubjectsEvent());
                },
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
          onSelectedSubjectsUpdate: (subjects) {
            _selectedSubjects = subjects;
            if (_selectedSubjects.isNotEmpty) {
              _subjectsBloc.add(OneOrMoreSubjectsSelectedEvent());
            } else {
              _subjectsBloc.add(NoSubjectsSelectedEvent());
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
