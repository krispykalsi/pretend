import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class SelectedSubjectListTile extends StatelessWidget {
  final Subject subject;
  final Animation<double> animation;
  final Function(Subject)? onTap;

  const SelectedSubjectListTile(
    this.subject, {
    Key? key,
    required this.animation,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: GestureDetector(
        onTap: () => onTap?.call(subject),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            subject.code,
            style: TextStyle(
              color: AppColors.PRIMARY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
