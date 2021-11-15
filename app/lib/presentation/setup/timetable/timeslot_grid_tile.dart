import 'package:flutter/material.dart';
import 'package:core/app_colors.dart';

class TimeslotGridTile extends StatefulWidget {
  final String timeslot;
  final Function(bool)? onTap;
  final bool? selected;
  final Color? selectedColor;

  const TimeslotGridTile(
    this.timeslot, {
    Key? key,
    this.onTap,
    this.selectedColor,
    this.selected,
  }) : super(key: key);

  @override
  _TimeslotGridTileState createState() => _TimeslotGridTileState();
}

class _TimeslotGridTileState extends State<TimeslotGridTile> {
  late bool isSelected = widget.selected ?? false;
  late Color color = widget.selectedColor ?? Colors.white;
  static const millis = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onTap?.call(isSelected);
        });
      },
      child: AnimatedContainer(
        color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
        duration: const Duration(milliseconds: millis),
        child: Center(
          child: Text(
            widget.timeslot,
            style: const TextStyle(
              color: AppColors.PRIMARY,
            ),
          ),
        ),
      ),
    );
  }
}
