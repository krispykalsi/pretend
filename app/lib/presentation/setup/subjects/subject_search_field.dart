import 'package:flutter/material.dart';
import 'package:core/app_colors.dart';

class SubjectSearchField extends StatefulWidget {
  final TextEditingController controller;

  const SubjectSearchField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SubjectSearchField> createState() => _SubjectSearchFieldState();
}

class _SubjectSearchFieldState extends State<SubjectSearchField> {
  bool _showCross = false;

  void _onTextChange() {
    if (_showCross != widget.controller.text.isNotEmpty) {
      setState(() => _showCross = widget.controller.text.isNotEmpty);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.accent.withOpacity(0.05),
          constraints: BoxConstraints.expand(height: 50),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _searchField,
            _horizontalDivider,
          ],
        ),
      ],
    );
  }

  TextField get _searchField {
    return TextField(
      scrollPadding: const EdgeInsets.all(0),
      cursorColor: Colors.white,
      controller: widget.controller,
      onEditingComplete: () {
        var text = widget.controller.text;
        print(text);
        widget.controller.text = text;
        FocusScope.of(context).unfocus();
      },
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.SECONDARY),
        suffixIcon: _showCross ? _clearButton : null,
        hintText: "Search by name or code",
        hintStyle: Theme.of(context).textTheme.bodyText2,
        border: InputBorder.none,
      ),
    );
  }

  IconButton get _clearButton {
    return IconButton(
      enableFeedback: false,
      onPressed: widget.controller.clear,
      icon: Icon(
        Icons.backspace,
        color: AppColors.accent,
      ),
    );
  }

  Container get _horizontalDivider {
    return Container(
      height: 1,
      color: AppColors.SECONDARY,
    );
  }
}
