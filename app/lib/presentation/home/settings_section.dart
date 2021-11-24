import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatefulWidget {
  final VoidCallback onThemeChangeTap;
  final VoidCallback onTimetableEditTap;

  const SettingsSection({
    Key? key,
    required this.onThemeChangeTap,
    required this.onTimetableEditTap,
  }) : super(key: key);

  @override
  _SettingsSectionState createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool _settingsOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
        color: AppColors.accent,
        boxShadow: [
          BoxShadow(
            color: AppColors.DARK,
            offset: Offset(-7,0),
            blurRadius: 10,
            spreadRadius: 3,
          )
        ]
      ),
      curve: Curves.easeOutCubic,
      constraints: BoxConstraints.tightFor(
        width: _settingsOpen ? 144 : 54,
        height: 54,
      ),
      padding: const EdgeInsets.all(12),
      duration: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _settingsOpen ? 1 : 0,
              child: _buildIconButton(
                Icons.edit,
                onTap: widget.onTimetableEditTap,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _settingsOpen ? 1 : 0,
              child: _buildIconButton(
                Icons.palette,
                onTap: widget.onThemeChangeTap,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildIconButton(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _settingsOpen = !_settingsOpen;
        });
        onTap?.call();
      },
      child: Icon(
        icon,
        color: AppColors.DARK,
        size: 30,
      ),
    );
  }
}
