import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

class ChosenSubjectsView extends StatelessWidget {
  final List<Subject> subjects = [
    Subject("Computer Networks", "IT-124"),
    Subject("Theory of Computing", "IT-128"),
    Subject("International Trade", "HU-351a"),
  ];

  ChosenSubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(index.toString() + "."),
          title: Text(subjects[index].name),
          subtitle: Text(subjects[index].code),
          trailing: IconButton(
            onPressed: () => print("clear"),
            icon: Icon(Icons.cancel_rounded),
          ),
        );
      },
      itemCount: subjects.length,
    );
  }
}
