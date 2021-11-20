import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

import 'subject_option_list_tile.dart';

class SubjectOptionList extends StatefulWidget {
  final Iterable<Subject> _subjects;
  final Function(Subject, bool) onOptionTap;
  final Iterable<Subject> _previouslySelected;
  final ValueNotifier<Subject> selectedListRemovalNotifier;

  const SubjectOptionList(
    this._subjects, {
    Key? key,
    required this.onOptionTap,
    required this.selectedListRemovalNotifier,
    Iterable<Subject> previousState = const [],
  })  : _previouslySelected = previousState,
        super(key: key);

  @override
  _SubjectOptionListState createState() => _SubjectOptionListState();
}

class _SubjectOptionListState extends State<SubjectOptionList> {
  late final Map<String, bool> _selectionState = {
    for (var sub in widget._previouslySelected) sub.code: true
  };

  void _onRemoveFromSelectedList() {
    final removedSubject = widget.selectedListRemovalNotifier.value;
    setState(() {
      _selectionState[removedSubject.code] = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.selectedListRemovalNotifier.addListener(_onRemoveFromSelectedList);
  }

  @override
  void dispose() {
    widget.selectedListRemovalNotifier.removeListener(_onRemoveFromSelectedList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment(0, 0.7),
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
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
        ),
      ),
    );
  }
}
