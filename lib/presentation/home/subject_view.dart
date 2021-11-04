import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/home/subject_category_badge.dart';
import 'package:pretend/presentation/home/time_components.dart';

class SubjectView extends StatelessWidget {
  final isOnGoing;
  final Subject subject;
  final Timeslot timeslot;

  const SubjectView({
    Key? key,
    required this.subject,
    required this.timeslot,
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
                    text: timeslot.classCategory,
                    color: AppColors.LAB,
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
            color: AppColors.SECONDARY,
            width: 1,
          ),
        ),
      )
    );
  }
}
