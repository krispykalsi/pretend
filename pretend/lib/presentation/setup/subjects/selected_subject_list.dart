import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:core/widgets.dart';

import 'selected_subject_list_tile.dart';

class SelectedSubjectList extends StatefulWidget {
  final ValueNotifier<AnimatedListModel<Subject>?> listModelNotifier;
  final List<Subject> previouslySelected;

  const SelectedSubjectList({
    Key? key,
    required this.listModelNotifier,
    this.previouslySelected = const [],
  }) : super(key: key);

  @override
  _SelectedSubjectListState createState() => _SelectedSubjectListState();
}

class _SelectedSubjectListState extends State<SelectedSubjectList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late final AnimatedListModel<Subject> listModel = AnimatedListModel<Subject>(
    listKey: listKey,
    removedItemBuilder: _buildRemovedItem,
    initialItems: widget.previouslySelected,
  );

  Widget _buildRemovedItem(
      Subject subject, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInExpo,
      ),
      child: SelectedSubjectListTile(subject, animation: animation),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.listModelNotifier.value = listModel;
  }

  @override
  void dispose() {
    widget.listModelNotifier.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: listModel.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SelectedSubjectListTile(
      listModel[index],
      animation: animation,
      onTap: (subject) {
        print(subject);
      },
    );
  }
}
