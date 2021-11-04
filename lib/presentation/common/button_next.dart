import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class ButtonNext extends StatelessWidget {
  final Function()? onTap;

  const ButtonNext({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: AppColors.ACCENT,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Next",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
              fontWeight: FontWeight.bold,
              color: AppColors.DARK,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
