import 'package:flutter/material.dart';
import 'package:core/app_colors.dart';

class SideHeading extends StatelessWidget {
  final String text;

  const SideHeading(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: AppColors.SECONDARY,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 10, bottom: 5, top: 5),
        child: Text(
          text,
          style: TextStyle(
            shadows: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(-2, 2),
                blurRadius: 7,
              )
            ],
            fontFamily: Theme.of(context).textTheme.headline3!.fontFamily,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline3!.color,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
