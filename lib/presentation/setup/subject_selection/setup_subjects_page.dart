import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/button_next.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';

import 'setup_subjects.dart';

class SetupSubjectsPage extends StatelessWidget {
  const SetupSubjectsPage({Key? key}) : super(key: key);

  final _subjects = const [
    Subject("Computer Networks", "IT-124"),
    Subject("Theory of Computing", "IT-128"),
    Subject("International Trade Very Long Subject Name", "HU-351a"),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select all your subjects",
      body: Stack(
        children: [
          SetupSubjects(_subjects),
          Positioned(
            right: 0,
            bottom: 100,
            child: ButtonNext(
              callback: () => print("next"),
            ),
          )
        ],
      ),
    );
  }
}
