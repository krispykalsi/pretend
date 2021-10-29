import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/days_enum.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/common/button_done.dart';
import 'package:pretend/presentation/common/custom_choice_chip.dart';
import 'package:pretend/presentation/setup/timetable/selection_state_notifier.dart';
import 'package:pretend/presentation/setup/timetable/subject_timetable.dart';
import 'package:pretend/presentation/setup/timetable/timeslot_grid_tile_state.dart';

import 'typedefs.dart';
import 'timeslot_grid.dart';

class TimetableSetup extends StatefulWidget {
  final void Function(WeekSelectionState) onTimetableUpdate;
  final VoidCallback onDone;

  const TimetableSetup({
    Key? key,
    required this.onTimetableUpdate,
    required this.onDone,
  }) : super(key: key);

  @override
  _TimetableSetupState createState() => _TimetableSetupState();
}

class _TimetableSetupState extends State<TimetableSetup> {
  final _selectedDayNotifier = ValueNotifier<String>(Days.MONDAY);
  final _selectionColorNotifier = ValueNotifier<Color>(AppColors.THEORY);
  final _selectionStateNotifier = SelectionStateNotifier();

  static const _CHIP_HEIGHT = 40.0;

  void _onTimeslotTap(String timeslot, TimeslotGridTileState state) {
    final _selectionState = _selectionStateNotifier.value;
    _selectionState.putIfAbsent(
        _selectedDayNotifier.value, () => DaySelectionState());
    _selectionState[_selectedDayNotifier.value]![timeslot] = state;
    _selectionStateNotifier.notifyListeners();
    widget.onTimetableUpdate(_selectionState);
  }

  @override
  void dispose() {
    _selectedDayNotifier.dispose();
    _selectionColorNotifier.dispose();
    _selectionStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubjectTimetable(selectionStateNotifier: _selectionStateNotifier),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ButtonDone(onTap: widget.onDone),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _timeslotGrid,
                        _classCategoryChoiceChips,
                      ],
                    ),
                  ),
                  _dayChoiceChips,
                ],
                // mainAxisSize: MainAxisSize.max,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _timeslotGrid {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: _CHIP_HEIGHT * 6,
      ),
      child: TimeslotGrid(
        onTap: _onTimeslotTap,
        selectedDay: _selectedDayNotifier,
        selectionColor: _selectionColorNotifier,
      ),
    );
  }

  Widget get _classCategoryChoiceChips {
    return Row(
      children: AppColors.classCategory.entries.map<Widget>((entry) {
        final classCategory = entry.key;
        final categoryColor = entry.value;
        return CustomChoiceChip(
          labelText: classCategory.toUpperCase(),
          selected: _selectionColorNotifier.value == categoryColor,
          selectedColor: categoryColor,
          unselectedLabelColor: categoryColor,
          onSelected: (isSelected) {
            setState(() {
              _selectionColorNotifier.value = categoryColor;
            });
          },
          height: _CHIP_HEIGHT,
        );
      }).toList(growable: false),
    );
  }

  Widget get _dayChoiceChips {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Days.values.map<Widget>((day) {
        return CustomChoiceChip(
          labelText: day[0].toUpperCase() + day[1] + day[2],
          selected: _selectedDayNotifier.value == day,
          onSelected: (isSelected) {
            setState(() {
              _selectedDayNotifier.value = day;
            });
          },
          width: 52,
          height: _CHIP_HEIGHT,
        );
      }).toList(growable: false),
    );
  }
}
