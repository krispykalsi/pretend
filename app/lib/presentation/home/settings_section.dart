import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pretend/application/router/router.gr.dart';

import 'settings_item_button.dart';

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
  bool _areSettingsOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
        color: AppColors.accent,
        boxShadow: [
          const BoxShadow(
            color: AppColors.DARK,
            offset: Offset(-7, 0),
            blurRadius: 10,
            spreadRadius: 3,
          )
        ],
      ),
      curve: Curves.easeOutCubic,
      constraints: BoxConstraints.tightFor(
        width: _areSettingsOpen ? 170 : 54,
        height: _areSettingsOpen ? 184 : 54,
      ),
      padding: const EdgeInsets.all(12),
      duration: const Duration(milliseconds: 300),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          _buildSettingsItem(
            MdiIcons.calendarEdit,
            "Edit Timetable",
            Alignment.topCenter,
            onTap: widget.onTimetableEditTap,
          ),
          _buildSettingsItem(
            Icons.palette,
            "Change Theme",
            Alignment(0, -0.33),
            onTap: widget.onThemeChangeTap,
          ),
          _buildSettingsItem(
            FontAwesomeIcons.info,
            "About App",
            Alignment(0, 0.33),
            onTap: () => context.router.push(const AboutRoute()),
          ),
          _buildSettingsItem(
            Icons.settings,
            "Settings",
            Alignment.bottomCenter,
            isGearIcon: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String text, Alignment alignment,
      {VoidCallback? onTap, bool isGearIcon = false}) {
    return Align(
      alignment: alignment,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _areSettingsOpen || isGearIcon ? 1 : 0,
        child: SettingsItemButton(
          expanded: _areSettingsOpen,
          icon: icon,
          text: text,
          onTap: () {
            setState(() => _areSettingsOpen = !_areSettingsOpen);
            onTap?.call();
          },
          isGearIcon: isGearIcon,
        ),
      ),
    );
  }
}
