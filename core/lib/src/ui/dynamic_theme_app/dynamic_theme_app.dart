import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

part 'get_theme_data.dart';
part 'theme_changer.dart';

final _themeGlobalKey = new GlobalKey(debugLabel: 'app_theme');

class DynamicThemeApp extends StatefulWidget {
  final Widget Function(ThemeData) buildChild;

  DynamicThemeApp({
    required this.buildChild,
  }) : super(key: _themeGlobalKey);

  @override
  DynamicThemeAppState createState() => new DynamicThemeAppState();
}

class DynamicThemeAppState extends State<DynamicThemeApp> {
  ThemeData _theme = _getThemeData;

  set theme(newTheme) {
    if (newTheme != _theme) {
      setState(() => _theme = newTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeChanger(
      appThemeKey: _themeGlobalKey,
      child: widget.buildChild(_theme),
    );
  }
}
