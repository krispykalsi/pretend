import 'package:core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/new_subject/new_subject_bloc.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:core/widgets.dart';
import 'package:core/app_colors.dart';
import 'package:pretend/presentation/setup/subjects/add_new_subject_dialog.dart';
import 'package:pretend/presentation/setup/subjects/no_subjects_in_list_section.dart';

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
  final _selectedListRemovalNotifier = ValueNotifier<Subject>(Subject("", ""));
  final _newSubjectAddedNotifier = ValueNotifier<Subject>(Subject("", ""));
  final _textEditingController = TextEditingController();
  Iterable<Subject> _subjectOptions = const Iterable.empty();
  final _newSubjectBloc = sl<NewSubjectBloc>();

  void _addToSelectedSubjects(Subject subject) {
    final len = _selectedListNotifier.value!.length;
    _selectedListNotifier.value!.insert(len, subject);
  }

  void _removeFromSelectedSubjects(Subject subject) {
    _selectedListNotifier.value!.remove(subject);
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

  void _onRemoveTapInSelectedList(Subject subject) {
    _selectedListRemovalNotifier.value = subject;
    _onOptionTap(subject, false);
  }

  void _onAddNewSubject() async {
    final subject = await showAddNewSubjectDialog(context);
    if (subject != null) {
      _newSubjectBloc.add(AddNewSubjectEvent(subject));
    }
  }

  void _updateSubjectOptionsList(String searchText) {
    _subjectOptions = widget.allSubjects.where(
      (subject) =>
          subject.name.containsAnywhere(searchText) ||
          subject.code.containsAnywhere(searchText),
    );
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      final fieldText = _textEditingController.text;
      setState(() => _updateSubjectOptionsList(fieldText));
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
        ? NoSubjectsInListSection(
            onAddNewSubject: _onAddNewSubject,
            onSubjectListUpdate: widget.onSubjectListUpdate,
          )
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
                child: _optionsSection,
              ),
              _verticalDivider,
              Expanded(
                flex: 1,
                child: SelectedSubjectList(
                  listModelNotifier: _selectedListNotifier,
                  previouslySelected: widget.previouslySelected,
                  onRemove: _onRemoveTapInSelectedList,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column get _optionsSection {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocConsumer<NewSubjectBloc, NewSubjectState>(
          bloc: _newSubjectBloc,
          listenWhen: (previous, current) => current is NewSubjectAdded,
          listener: (context, state) {
            if (state is NewSubjectAdded) {
              widget.onSubjectListUpdate();
              _newSubjectAddedNotifier.value = state.subject;
              _onOptionTap(state.subject, true);
            }
          },
          buildWhen: (prevous, current) => current is NewSubjectInitial,
          builder: (context, state) {
            return _subjectOptions.isEmpty &&
                    _textEditingController.text.isEmpty
                ? NoSubjectsInListSection(
                    alreadyFetchedOnce: true,
                    onAddNewSubject: _onAddNewSubject,
                    onSubjectListUpdate: widget.onSubjectListUpdate,
                  )
                : Flexible(
                    child: SubjectOptionList(
                      _subjectOptions,
                      previousState: widget.previouslySelected,
                      onOptionTap: _onOptionTap,
                      selectedListRemovalNotifier: _selectedListRemovalNotifier,
                      newSubjectAddedNotifier: _newSubjectAddedNotifier,
                    ),
                  );
          },
        ),
        _addNewSubjectSection,
      ],
    );
  }

  Container get _verticalDivider {
    return Container(
      width: 1,
      color: AppColors.SECONDARY,
    );
  }

  Widget get _addNewSubjectSection {
    return BlocBuilder(
      bloc: _newSubjectBloc,
      builder: (context, state) {
        if (state is NewSubjectInitial) {
          return _textEditingController.text.isNotEmpty
              ? AddNewSubjectButton(onTap: _onAddNewSubject)
              : const SizedBox.shrink();
        } else if (state is NewSubjectBeingAdded) {
          return const CircularProgressIndicator();
        } else if (state is NewSubjectAdded) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Added successfully!",
              style: TextStyle(color: Colors.green),
            ),
          );
        } else if (state is CouldNotAddNewSubject) {
          return ErrorPuu(
            title: "Failed to add subject",
            body: "Try reinstalling the app",
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
