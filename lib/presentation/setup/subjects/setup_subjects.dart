import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/new_subject/new_subject_bloc.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/animated_list_model.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/setup/subjects/add_new_subject_dialog.dart';

import '../../../injection_container.dart';
import 'selected_subject_list.dart';
import 'subject_search_field.dart';
import 'subject_option_list.dart';
import 'add_new_subject_button.dart';

class SetupSubjects extends StatefulWidget {
  final List<Subject> allSubjects;
  final List<Subject> previouslySelected;
  final VoidCallback onSubjectListUpdate;
  final Function(List<Subject>) onSelectedSubjectsUpdate;

  const SetupSubjects({
    Key? key,
    this.previouslySelected = const [],
    required this.allSubjects,
    required this.onSelectedSubjectsUpdate,
    required this.onSubjectListUpdate,
  }) : super(key: key);

  @override
  _SetupSubjectsState createState() => _SetupSubjectsState();
}

class _SetupSubjectsState extends State<SetupSubjects> {
  final _selectedListNotifier =
      ValueNotifier<AnimatedListModel<Subject>?>(null);
  var _textEditingController = TextEditingController();
  Iterable<Subject> _subjectOptions = Iterable.empty();
  final _newSubjectBloc = sl<NewSubjectBloc>();

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

  void _onAddNewSubject() async {
    final subject = await showAddNewSubjectDialog(context);
    if (subject != null) {
      _newSubjectBloc.add(AddNewSubjectEvent(subject));
      widget.onSubjectListUpdate();
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
    return widget.allSubjects.isEmpty
        ? _buildAddNewSubjectButton
        : _buildSubjectSearchSection;
  }

  Widget get _buildSubjectSearchSection {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SubjectSearchField(controller: _textEditingController),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SubjectOptionList(
                        _subjectOptions,
                        previousState: widget.previouslySelected,
                        onOptionTap: _onOptionTap,
                      ),
                    ),
                    _buildAddNewSubjectSection,
                  ],
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

  Widget get _buildAddNewSubjectButton {
    return Center(
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text(
              "Add Subject Manually",
            ),
          ],
        ),
        onPressed: _onAddNewSubject,
      ),
    );
  }

  Widget get _buildAddNewSubjectSection {
    return BlocBuilder(
      bloc: _newSubjectBloc,
      builder: (context, state) {
        if (state is NewSubjectInitial) {
          return _textEditingController.text.isNotEmpty
              ? AddNewSubjectButton(onTap: _onAddNewSubject)
              : SizedBox.shrink();
        } else if (state is NewSubjectBeingAdded) {
          return CircularProgressIndicator();
        } else if (state is NewSubjectAdded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Added successfully!",
              style: TextStyle(color: Colors.green),
            ),
          );
        } else if (state is CouldNotAddNewSubject) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Failed to add subject",
              style: TextStyle(color: Colors.redAccent),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
