import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

class SubjectListTile extends StatelessWidget {
  final bool isConfigured;
  final Subject subject;
  final VoidCallback onTap;

  const SubjectListTile({
    Key? key,
    required this.isConfigured,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  Icon get prefixIcon => isConfigured
      ? const Icon(
          Icons.check,
          color: Colors.green,
        )
      : const Icon(
          Icons.cancel,
          color: Colors.transparent,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: prefixIcon,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  subject.code,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          _rightArrow,
        ],
      ),
    );
  }

  Padding get _rightArrow {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.arrow_right_rounded,
        color: AppColors.accent,
        size: 32,
      ),
    );
  }
}
