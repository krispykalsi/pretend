import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:core/app_colors.dart';

import 'typedefs.dart';

class SubjectTimetable extends StatefulWidget {
  final ValueNotifier<WeekSelectionState> selectionStateNotifier;

  const SubjectTimetable({
    Key? key,
    required this.selectionStateNotifier,
  }) : super(key: key);

  @override
  _SubjectTimetableState createState() => _SubjectTimetableState();
}

class _SubjectTimetableState extends State<SubjectTimetable> {
  late WeekSelectionState _selectionState = widget.selectionStateNotifier.value;

  void _selectionStateListener() {
    setState(() {
      _selectionState = widget.selectionStateNotifier.value;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.selectionStateNotifier.addListener(_selectionStateListener);
  }

  @override
  void dispose() {
    widget.selectionStateNotifier.removeListener(_selectionStateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Days.values.map<Widget>((day) {
        _selectionState.putIfAbsent(day, () => DaySelectionState());
        final timeslots = _selectionState[day]!.keys.where((timeslot) {
          return _selectionState[day]![timeslot]?.isSelected ?? false;
        });
        final sortedTimeslots = timeslots.sorted((a, b) => a.compareTo(b));
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _horizontalDivider,
              _buildDayHeading(day),
              _horizontalDivider,
              _buildSelectedTimeslots(sortedTimeslots, day)
            ],
          ),
        );
      }).toList(growable: false),
    );
  }

  Column _buildSelectedTimeslots(List<Timeslots> sortedTimeslots, String day) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedTimeslots.map<Widget>((timeslot) {
        final state = _selectionState[day]![timeslot];
        final color = state?.color ?? AppColors.THEORY;
        final category = getClassCategoryFromColor(color);
        var categoryInitial = category[0].toUpperCase();
        if (categoryInitial == "T") categoryInitial += category[1];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeslot.dashed,
                style: const TextStyle(color: AppColors.PRIMARY),
              ),
              Text(
                categoryInitial,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(growable: false),
    );
  }

  Text _buildDayHeading(String day) {
    return Text(
      day,
      style: const TextStyle(
        color: AppColors.PRIMARY,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container get _horizontalDivider {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.SECONDARY,
      height: 1,
    );
  }
}
