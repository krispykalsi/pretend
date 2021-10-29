import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

import 'typedefs.dart';
import 'timeslot_grid_tile.dart';
import 'timeslot_grid_tile_state.dart';

class TimeslotGrid extends StatefulWidget {
  static const _timeslots = [
    ["8-9", "9-10", "10-11", "11-12"],
    ["12-1", "1-2", "2-3", "3-4"],
    ["4-5", "5-6", "6-7", "7-8"],
  ];

  final void Function(String, TimeslotGridTileState)? onTap;
  final ValueNotifier<String> selectedDay;
  final ValueNotifier<Color> selectionColor;

  const TimeslotGrid({
    Key? key,
    this.onTap,
    required this.selectedDay,
    required this.selectionColor,
  }) : super(key: key);

  @override
  _TimeslotGridState createState() => _TimeslotGridState();
}

class _TimeslotGridState extends State<TimeslotGrid> {
  late String _selectedDay = widget.selectedDay.value;
  late Color _selectionColor = widget.selectionColor.value;
  var _selectionState = WeekSelectionState();

  void _selectedDayListener() {
    setState(() {
      _selectedDay = widget.selectedDay.value;
    });
  }

  void _selectedClassCategoryListener() {
    setState(() {
      _selectionColor = widget.selectionColor.value;
    });
  }

  void _onTimeslotTap(String timeslot, bool isSelected) {
    _selectionState.putIfAbsent(
      _selectedDay,
      () => DaySelectionState(),
    );
    final state = TimeslotGridTileState(isSelected, _selectionColor);
    _selectionState[_selectedDay]![timeslot] = state;
    widget.onTap?.call(timeslot, state);
  }

  @override
  void initState() {
    super.initState();
    widget.selectedDay.addListener(_selectedDayListener);
    widget.selectionColor.addListener(_selectedClassCategoryListener);
  }

  @override
  void dispose() {
    widget.selectedDay.removeListener(_selectedDayListener);
    widget.selectionColor.removeListener(_selectedClassCategoryListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List<Widget>.generate(TimeslotGrid._timeslots.length + 1, (_) {
            return Container(height: 1, color: AppColors.SECONDARY);
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List<Widget>.generate(TimeslotGrid._timeslots[0].length + 1, (_) {
            return Container(width: 1, color: AppColors.SECONDARY);
          }),
        ),
        Column(
          children: TimeslotGrid._timeslots.map((row) {
            return Expanded(
              child: Row(
                children: row.map((timeslot) {
                  return Expanded(
                    child: buildTile(timeslot),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  TimeslotGridTile buildTile(String timeslot) {
    return TimeslotGridTile(
      timeslot,
      key: UniqueKey(),
      onTap: (isSelected) => _onTimeslotTap(timeslot, isSelected),
      selected: _selectionState[_selectedDay]?[timeslot]?.isSelected,
      selectedColor:
          _selectionState[_selectedDay]?[timeslot]?.color ?? _selectionColor,
    );
  }
}
