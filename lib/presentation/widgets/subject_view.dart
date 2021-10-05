import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/time_set.dart';
import 'package:pretend/presentation/widgets/subject_category_badge.dart';
import 'package:pretend/presentation/widgets/time_components.dart';

const YELLOW = Color(0xfffff733);
const CYAN = Color(0xff33f3ff);
const GREEN = Color(0xff99ff33);
const DARK = Color(0xff242424);
const OFF_WHITE = Color(0xffe5e5e5);

class SubjectView extends StatelessWidget {
  final isOnGoing;
  final Subject subject;
  final TimeSet timeSet;

  const SubjectView({
    Key? key,
    required this.subject,
    required this.timeSet,
    this.isOnGoing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            children: [
              isOnGoing ? TimeLeftTimeComponent() : StartsAtTimeComponent(),
              CustomVerticalDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.code,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SubjectCategoryBadge(
                    text: timeSet.classCategory,
                    color: YELLOW,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Container(
            color: OFF_WHITE,
            width: 1,
          ),
        ),
      )
    );
  }
}
