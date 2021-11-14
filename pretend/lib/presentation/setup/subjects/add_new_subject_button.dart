import 'package:flutter/material.dart';
import 'package:core/app_colors.dart';

class AddNewSubjectButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewSubjectButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Didn't find your subject?",
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Add here",
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
