import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

class CompactSubjectView extends StatelessWidget {
  final Subject subject;

  const CompactSubjectView(this.subject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subject.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            subject.code,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
