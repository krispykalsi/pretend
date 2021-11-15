import 'dart:ui';

import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool firstTimeStartup;
  final Color? themeColor;

  const AppSettings({required this.firstTimeStartup, required this.themeColor});

  @override
  List<Object?> get props => [firstTimeStartup, themeColor];
}
