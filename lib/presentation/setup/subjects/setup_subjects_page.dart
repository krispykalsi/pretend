import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/subjects_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/injection_container.dart';
import 'package:pretend/presentation/common/button_next.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

import 'setup_subjects.dart';

class SetupSubjectsPage extends StatefulWidget {
  const SetupSubjectsPage({Key? key}) : super(key: key);

  @override
  _SetupSubjectsPageState createState() => _SetupSubjectsPageState();
}

class _SetupSubjectsPageState extends State<SetupSubjectsPage> {
  var _selectedSubjects = List<Subject>.empty();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select all your subjects",
      body: BlocProvider(
        create: (context) => sl<SubjectsBloc>(),
        child: BlocBuilder<SubjectsBloc, SubjectsState>(
          builder: (context, state) {
            if (state is Loaded) {
              return _buildLoadedState(state);
            } else if (state is Loading) {
              return CircularProgressIndicator();
            } else if (state is Initial) {
              BlocProvider.of<SubjectsBloc>(context).add(const GetAllSubjectsEvent());
              return SizedBox.shrink();
            } else {
              return Center(
                child: ElevatedButton(
                  child: Text("load subs"),
                  onPressed: () {
                    BlocProvider.of<SubjectsBloc>(context).add(const GetAllSubjectsEvent());
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Stack _buildLoadedState(Loaded state) {
    return Stack(
      children: [
        SetupSubjects(
          allSubjects: state.subjects,
          onSelectedSubjectsUpdate: (subjects) => _selectedSubjects = subjects,
        ),
        Positioned(
          right: 0,
          bottom: 100,
          child: ButtonNext(
            onTap: () => context.router
                .push(TimetableSetupStatusRoute(subjects: _selectedSubjects)),
          ),
        )
      ],
    );
  }
}
