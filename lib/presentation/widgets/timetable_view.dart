import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/time_set.dart';
import 'package:pretend/presentation/widgets/subject_view.dart';

class TimetableView extends StatelessWidget {
  const TimetableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tSubject = Subject("Machine Learning", "IT-102");
    final tTimeSet = TimeSet(
      start: "1:00 PM",
      end: "2:00 PM",
      duration: 1,
      classCategory: "theory",
      subjectKey: "randomKey",
    );

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeading("Ongoing", context),
              SizedBox(height: 10),
              SubjectView(
                subject: tSubject,
                timeSet: tTimeSet,
                isOnGoing: true,
              ),
            ],
          ),
          SizedBox(height: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionHeading("Later today", context),
                Expanded(
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    itemBuilder: (context, idx) {
                      return SubjectView(
                        subject: tSubject,
                        timeSet: tTimeSet,
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text buildSectionHeading(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
