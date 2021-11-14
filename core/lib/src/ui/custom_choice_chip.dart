import 'package:flutter/material.dart';
import 'app_colors.dart';

class CustomChoiceChip extends StatelessWidget {
  final String labelText;
  final bool selected;
  final Function(bool) onSelected;
  final bool expandWidth;
  final double? width;
  final double? height;
  final Alignment? labelAlignment;
  final Color? selectedColor;
  final Color? unselectedLabelColor;

  const CustomChoiceChip({
    Key? key,
    required this.labelText,
    required this.selected,
    required this.onSelected,
    this.width,
    this.height,
    this.labelAlignment,
    this.selectedColor,
    this.unselectedLabelColor,
    this.expandWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipThemeData.fromDefaults(
        primaryColor: unselectedLabelColor ?? Colors.white,
        secondaryColor: AppColors.DARK,
        labelStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: chip,
    );
  }

  ChoiceChip get chip => ChoiceChip(
        shape: ContinuousRectangleBorder(),
        backgroundColor: Color(0xff555555),
        selectedColor: selectedColor ?? AppColors.accent,
        padding: const EdgeInsets.all(10),
        label: label,
        selected: selected,
        onSelected: onSelected,
      );

  Widget get label => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ?? 0,
          minHeight: height ?? 0,
          maxWidth: width ?? double.infinity,
          maxHeight: height ?? double.infinity,
        ),
        child: Stack(
          fit: expandWidth ? StackFit.expand : StackFit.loose,
          children: [
            Align(
              alignment: labelAlignment ?? Alignment.center,
              child: Text(labelText),
            ),
          ],
        ),
      );
}
