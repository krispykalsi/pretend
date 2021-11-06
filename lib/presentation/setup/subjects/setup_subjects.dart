import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/animated_list_model.dart';
import 'package:pretend/presentation/common/app_colors.dart';

import 'selected_subject_list.dart';
import 'subject_search_field.dart';
import 'subject_option_list.dart';

class SetupSubjects extends StatefulWidget {
  final List<Subject> allSubjects;
  final List<Subject> previouslySelected;
  final Function(List<Subject>) onSelectedSubjectsUpdate;

  const SetupSubjects({
    Key? key,
    this.previouslySelected = const [],
    required this.allSubjects,
    required this.onSelectedSubjectsUpdate,
  }) : super(key: key);

  @override
  _SetupSubjectsState createState() => _SetupSubjectsState();
}

class _SetupSubjectsState extends State<SetupSubjects> {
  final _selectedListNotifier =
      ValueNotifier<AnimatedListModel<Subject>?>(null);
  var _textEditingController = TextEditingController();
  Iterable<Subject> _subjectOptions = Iterable.empty();

  void _addToSelectedSubjects(Subject subject) {
    final len = _selectedListNotifier.value!.length;
    _selectedListNotifier.value!.insert(len, subject);
  }

  void _removeFromSelectedSubjects(Subject subject) {
    final index = _selectedListNotifier.value!.indexOf(subject);
    _selectedListNotifier.value!.removeAt(index);
  }

  void _onOptionTap(Subject subject, bool isSelected) {
    if (_selectedListNotifier.value != null) {
      isSelected
          ? _addToSelectedSubjects(subject)
          : _removeFromSelectedSubjects(subject);
      final subjects = _selectedListNotifier.value!.items;
      widget.onSelectedSubjectsUpdate(subjects);
    }
  }

  RegExp _getRegexpForIntelligentAutoComplete(String text) {
    return RegExp(
        text == ""
            ? r'$[\W\D\S-]^'
            : text.replaceAllMapped(RegExp(r'[^ ]'), (Match m) {
                return m[0]! + ".*? ?";
              }),
        caseSensitive: false);
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      var regexp =
          _getRegexpForIntelligentAutoComplete(_textEditingController.text);
      setState(() {
        _subjectOptions = widget.allSubjects.where(
          (element) =>
              element.name.contains(regexp) || element.code.contains(regexp),
        );
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _selectedListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SubjectSearchField(controller: _textEditingController),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SubjectOptionList(
                  _subjectOptions,
                  previousState: widget.previouslySelected,
                  onOptionTap: _onOptionTap,
                ),
              ),
              Container(
                width: 1,
                color: AppColors.SECONDARY,
              ),
              Expanded(
                flex: 1,
                child: SelectedSubjectList(
                  listModelNotifier: _selectedListNotifier,
                  previouslySelected: widget.previouslySelected,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
