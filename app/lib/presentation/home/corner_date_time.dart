import 'package:core/app_colors.dart';
import 'package:core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class CornerDateTime extends StatelessWidget {
  const CornerDateTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = sprintf("%02i", [now.day]);
    final month = now.monthString.toUpperCase();
    final day = now.weekdayString.toUpperCase();
    const textStyle = TextStyle(
      color: Colors.white12,
      fontSize: 64,
      height: 0.9,
      fontWeight: FontWeight.bold,
    );

    return Transform.translate(
      offset: const Offset(0, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-10, -10),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(day, style: textStyle),
            ),
          ),
          Row(
            children: [
              Text(
                date,
                style: textStyle.copyWith(
                  color: AppColors.accent.withOpacity(0.4),
                ),
              ),
              Text(month, style: textStyle),
            ],
          ),
        ],
      ),
    );
  }
}
