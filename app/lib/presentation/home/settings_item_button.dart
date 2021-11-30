import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsItemButton extends StatelessWidget {
  const SettingsItemButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.expanded,
    required this.onTap,
    this.isGearIcon = false,
  }) : super(key: key);

  final bool expanded;
  final IconData icon;
  final String text;
  final bool isGearIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          AnimatedRotation(
            turns: expanded && isGearIcon ? 0.4 : 0,
            duration: const Duration(milliseconds: 300),
            child: Icon(icon, color: AppColors.DARK, size: 30),
          ),
          Expanded(
            child: AnimatedScale(
              scale: expanded ? 1 : 0,
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  text,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: AppColors.DARK,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
