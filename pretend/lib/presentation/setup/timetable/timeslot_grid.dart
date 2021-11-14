import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:core/app_colors.dart';
import 'package:pretend/presentation/setup/timetable/selection_state_notifier.dart';

import 'typedefs.dart';
import 'timeslot_grid_tile.dart';
import 'timeslot_grid_tile_state.dart';

class TimeslotGrid extends StatefulWidget {
  static const _timeslots = [
    [Timeslots.T8AM, Timeslots.T9AM, Timeslots.T10AM, Timeslots.T11AM],
    [Timeslots.T12PM, Timeslots.T1PM, Timeslots.T2PM, Timeslots.T3PM],
    [Timeslots.T4PM, Timeslots.T5PM, Timeslots.T6PM, Timeslots.T7PM],
  ];

  final ValueNotifier<String> selectedDay;
  final ValueNotifier<Color> selectionColor;
  final SelectionStateNotifier selectionState;

  const TimeslotGrid({
    Key? key,
    required this.selectedDay,
    required this.selectionColor,
    required this.selectionState,
  }) : super(key: key);

  @override
  _TimeslotGridState createState() => _TimeslotGridState();
}

class _TimeslotGridState extends State<TimeslotGrid> {
  void _onTimeslotTap(Timeslots timeslot, bool isSelected) {
    final _selectedDay = widget.selectedDay.value;
    final _selectionColor = widget.selectionColor.value;
    final _selectionState = widget.selectionState.value;

    final state = TimeslotGridTileState(isSelected, _selectionColor);
    _selectionState.putIfAbsent(_selectedDay, () => DaySelectionState());
    _selectionState[_selectedDay]![timeslot] = state;
    widget.selectionState.notifyListeners();
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

  TimeslotGridTile buildTile(Timeslots timeslot) {
    final _selectionState = widget.selectionState.value;
    final _selectedDay = widget.selectedDay.value;
    final _selectionColor = widget.selectionColor.value;

    return TimeslotGridTile(
      timeslot.dashed,
      key: UniqueKey(),
      onTap: (isSelected) => _onTimeslotTap(timeslot, isSelected),
      selected: _selectionState[_selectedDay]?[timeslot]?.isSelected,
      selectedColor:
          _selectionState[_selectedDay]?[timeslot]?.color ?? _selectionColor,
    );
  }
}
