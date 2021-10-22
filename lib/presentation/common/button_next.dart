import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class ButtonNext extends StatelessWidget {
  final Function()? callback;

  const ButtonNext({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
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
