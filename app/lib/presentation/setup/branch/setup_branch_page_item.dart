import 'package:flutter/material.dart';
import 'package:core/widgets.dart';
import 'package:pretend/presentation/setup/branch/side_heading.dart';

void _defaultOnSelected(int _) {}

class SetupBranchPageItem extends StatefulWidget {
  final String category;
  final List<String>? chipLabels;
  final Widget? child;
  final Function(int) onSelected;

  const SetupBranchPageItem({
    Key? key,
    required this.category,
    this.child,
    this.chipLabels,
    this.onSelected = _defaultOnSelected,
  })  : assert(child != null || chipLabels != null),
        super(key: key);

  @override
  _SetupBranchPageItemState createState() => _SetupBranchPageItemState();
}

class _SetupBranchPageItemState extends State<SetupBranchPageItem> {
  int _chipValue = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          SideHeading(widget.category),
          const Spacer(),
          widget.child != null ? widget.child! : chips,
          const Spacer(),
        ],
      ),
    );
  }

  Widget get chips {
    return Row(
      children: List<Widget>.generate(
        widget.chipLabels!.length,
        (int index) {
          return CustomChoiceChip(
            labelText: widget.chipLabels![index],
            selected: _chipValue == index,
            onSelected: (bool selected) {
              setState(() {
                _chipValue = selected ? index : -1;
              });
              widget.onSelected(index);
            },
          );
        },
      ).toList(),
    );
  }
}
