import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/class_category_enum.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:core/app_colors.dart';
import 'package:core/widgets.dart';
import 'package:pretend/presentation/setup/timetable/selection_state_notifier.dart';
import 'package:pretend/presentation/setup/timetable/subject_timetable.dart';

import 'timeslot_grid.dart';

class TimetableSetup extends StatefulWidget {
  final SelectionStateNotifier selectionStateNotifier;
  final VoidCallback onDone;

  const TimetableSetup({
    Key? key,
    required this.selectionStateNotifier,
    required this.onDone,
  }) : super(key: key);

  @override
  _TimetableSetupState createState() => _TimetableSetupState();
}

class _TimetableSetupState extends State<TimetableSetup> {
  final _selectedDayNotifier = ValueNotifier<String>(Days.monday);
  final _selectionColorNotifier = ValueNotifier<Color>(AppColors.THEORY);

  static const _chipHeight = 40.0;

  @override
  void dispose() {
    _selectedDayNotifier.dispose();
    _selectionColorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubjectTimetable(selectionStateNotifier: widget.selectionStateNotifier),
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
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _classCategoryChoiceChips,
                    _timeslotGrid,
                    _dayChoiceChips,
                  ],
                  // mainAxisSize: MainAxisSize.max,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _timeslotGrid {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: _chipHeight * 4,
      ),
      child: TimeslotGrid(
        selectionState: widget.selectionStateNotifier,
        selectedDay: _selectedDayNotifier,
        selectionColor: _selectionColorNotifier,
      ),
    );
  }

  Widget get _classCategoryChoiceChips {
    return Row(
      children: ClassCategory.colors.entries.map<Widget>((entry) {
        final classCategory = entry.key;
        final categoryColor = entry.value;
        return Expanded(
          flex: classCategory == ClassCategories.lab ? 2 : 3,
          child: CustomChoiceChip(
            labelText: classCategory.toUpperCase(),
            selected: _selectionColorNotifier.value == categoryColor,
            selectedColor: categoryColor,
            unselectedLabelColor: categoryColor,
            onSelected: (isSelected) {
              setState(() {
                _selectionColorNotifier.value = categoryColor;
              });
            },
            height: _chipHeight,
            expandWidth: true,
          ),
        );
      }).toList(growable: false),
    );
  }

  Widget get _dayChoiceChips {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: Days.withoutSunday.map<Widget>((day) {
        return Expanded(
          child: CustomChoiceChip(
            labelText: day[0].toUpperCase(),
            selected: _selectedDayNotifier.value == day,
            onSelected: (isSelected) {
              setState(() {
                _selectedDayNotifier.value = day;
              });
            },
            expandWidth: true,
            height: _chipHeight,
          ),
        );
      }).toList(growable: false),
    );
  }
}
