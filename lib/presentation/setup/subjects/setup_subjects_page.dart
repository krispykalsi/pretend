import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/button_next.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

import 'setup_subjects.dart';

class SetupSubjectsPage extends StatefulWidget {
  const SetupSubjectsPage({Key? key}) : super(key: key);

  @override
  _SetupSubjectsPageState createState() => _SetupSubjectsPageState();
}

class _SetupSubjectsPageState extends State<SetupSubjectsPage> {
  final _subjects = const [
    Subject("Computer Networks", "IT-124"),
    Subject("Theory of Computing", "IT-128"),
    Subject("International Trade Very Long Subject Name", "HU-351a"),
  ];

  var _selectedSubjects = List<Subject>.empty();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select all your subjects",
      body: Stack(
        children: [
          SetupSubjects(
            allSubjects: _subjects,
            onSelectedSubjectsUpdate: (subjects) =>
                _selectedSubjects = subjects,
          ),
          Positioned(
            right: 0,
            bottom: 100,
            child: ButtonNext(
              callback: () => print(_selectedSubjects),
            ),
          )
        ],
      ),
    );
  }
}
