import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:core/app_colors.dart';

class SelectedSubjectListTile extends StatefulWidget {
  final Subject subject;
  final Animation<double> animation;
  final VoidCallback onRemove;

  const SelectedSubjectListTile(
    this.subject, {
    Key? key,
    required this.animation,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<SelectedSubjectListTile> createState() =>
      _SelectedSubjectListTileState();
}

class _SelectedSubjectListTileState extends State<SelectedSubjectListTile> {
  bool _showRemoveButton = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _showRemoveButton = !_showRemoveButton),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _tileContent,
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                top: 5,
                right: _showRemoveButton ? -5 : -70,
                child: _removeButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _tileContent {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.subject.code,
          style: const TextStyle(
            color: AppColors.PRIMARY,
            fontWeight: FontWeight.bold,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(widget.subject.name),
        )
      ],
    );
  }

  Widget get _removeButton {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.5,
          colors: [Colors.black54, Colors.transparent]
        )
      ),
      child: IconButton(
        enableFeedback: true,
        padding: const EdgeInsets.all(0),
        visualDensity: VisualDensity.compact,
        onPressed: widget.onRemove,
        icon: Icon(
          Icons.remove_circle,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
