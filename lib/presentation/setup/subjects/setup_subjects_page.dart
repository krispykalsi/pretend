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
  const SetupSubjectsPage({Key? key}) : super(key: key);

  @override
  _SetupSubjectsPageState createState() => _SetupSubjectsPageState();
}

class _SetupSubjectsPageState extends State<SetupSubjectsPage> {
  var _selectedSubjects = List<Subject>.empty();
  bool _shouldShowNext = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select all your subjects",
      body: BlocBuilder<SubjectsBloc, SubjectsState>(
        bloc: _subjectsBloc,
        builder: (context, state) {
          if (state is Loaded) {
            return _buildLoadedState(state.subjects);
          } else if (state is OneOrMoreSubjectsSelected) {
            return _buildLoadedState(state.subjects);
          } else if (state is Loading) {
            return CircularProgressIndicator();
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
    );
  }

  Stack _buildLoadedState(List<Subject> subs) {
    return Stack(
      children: [
        SetupSubjects(
          allSubjects: subs,
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
            onTap: () => context.router
                .push(TimetableSetupStatusRoute(subjects: _selectedSubjects)),
          ),
        );
      },
    );
  }
}
