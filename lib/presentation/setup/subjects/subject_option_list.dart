import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

import 'subject_option_list_tile.dart';

class SubjectOptionList extends StatefulWidget {
  final Iterable<Subject> _subjects;
  final Function(Subject, bool) onOptionTap;
  final Iterable<Subject> _previouslySelected;

  const SubjectOptionList(
    this._subjects, {
    Key? key,
    required this.onOptionTap,
    Iterable<Subject> previousState = const [],
  })  : _previouslySelected = previousState,
        super(key: key);

  @override
  _SubjectOptionListState createState() => _SubjectOptionListState();
}

class _SubjectOptionListState extends State<SubjectOptionList> {
  late Map<String, bool> _selectionState = Map.fromIterable(
    widget._previouslySelected,
    key: (sub) => sub.code,
    value: (_) => true,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (ctx, idx) {
          final subject = widget._subjects.elementAt(idx);
          return SubjectOptionListTile(
            subject,
            key: ValueKey(subject.code),
            onTap: (isSelected) {
              _selectionState[subject.code] = isSelected;
              widget.onOptionTap(subject, isSelected);
            },
            selected: _selectionState[subject.code] ?? false,
          );
        },
        itemCount: widget._subjects.length,
      ),
    );
  }
}
