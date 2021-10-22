import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class CustomChoiceChip extends StatelessWidget {
  final String labelText;
  final bool selected;
  final Function(bool) onSelected;

  const CustomChoiceChip({
    Key? key,
    required this.labelText,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipThemeData.fromDefaults(
        primaryColor: Colors.white,
        secondaryColor: AppColors.DARK,
        labelStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: ChoiceChip(
        shape: ContinuousRectangleBorder(),
        backgroundColor: Color(0xff555555),
        selectedColor: AppColors.ACCENT,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        label: Text(labelText),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}
