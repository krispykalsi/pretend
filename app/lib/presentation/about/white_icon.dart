import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';

class WhiteIcon extends StatelessWidget {
  final IconData icon;

  const WhiteIcon(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: AppColors.PRIMARY);
  }
}
