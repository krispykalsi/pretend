import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';


class AboutSection extends StatelessWidget {
  final String heading;
  final Widget body;

  const AboutSection({
    Key? key,
    required this.heading,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading,
        body,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget get _sectionHeading => Text(
    heading,
    style: const TextStyle(
      color: AppColors.SECONDARY,
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
  );
}

