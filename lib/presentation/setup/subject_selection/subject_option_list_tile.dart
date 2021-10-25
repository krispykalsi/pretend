import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

class SubjectOptionListTile extends StatefulWidget {
  final Subject subject;
  final Function(bool)? onTap;
  final bool selected;

  const SubjectOptionListTile(
    this.subject, {
    Key? key,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  _SubjectOptionListTileState createState() =>
      _SubjectOptionListTileState();
}

class _SubjectOptionListTileState extends State<SubjectOptionListTile> {

  late bool isSelected = widget.selected;
  static const millis = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onTap?.call(isSelected);
        });
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.all(12.0),
        color: isSelected ? Colors.white12 : Colors.transparent,
        duration: const Duration(milliseconds: millis),
        child: _ListTileContent(widget.subject),
      ),
    );
  }
}

class _ListTileContent extends StatelessWidget {
  const _ListTileContent(this.subject, {Key? key}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subject.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          subject.code,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
