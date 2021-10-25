import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/animated_list_model.dart';

import 'selected_subject_list_tile.dart';

class SelectedSubjectList extends StatefulWidget {
  final ValueNotifier<AnimatedListModel<Subject>?> listModelNotifier;

  const SelectedSubjectList({Key? key, required this.listModelNotifier})
      : super(key: key);

  @override
  _SelectedSubjectListState createState() => _SelectedSubjectListState();
}

class _SelectedSubjectListState extends State<SelectedSubjectList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late final AnimatedListModel<Subject> list = AnimatedListModel<Subject>(
    listKey: listKey,
    removedItemBuilder: _buildRemovedItem,
  );

  Widget _buildRemovedItem(Subject subject, BuildContext context,
      Animation<double> animation) {
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
    widget.listModelNotifier.value = list;
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
      initialItemCount: list.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation) {
    return SelectedSubjectListTile(
      list[index],
      animation: animation,
      onTap: (subject) {
        print(subject);
      },
    );
  }
}
