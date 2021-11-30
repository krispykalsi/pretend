import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:core/app_colors.dart';

import 'subject_category_badge.dart';
import 'time_components.dart';

part 'custom_vertical_divider.dart';

class SubjectListTile extends StatelessWidget {
  final bool isOnGoing;
  final Subject subject;
  final Timeslot timeslot;

  const SubjectListTile(
    this.subject,
    this.timeslot, {
    Key? key,
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            children: [
              TimeComponent(timeslot, showTimeLeft: isOnGoing),
              const _CustomVerticalDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.code,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SubjectCategoryBadge(
                    text: timeslot.classCategory,
                    color: ClassCategory.colors[timeslot.classCategory] ??
                        AppColors.PRIMARY,
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
