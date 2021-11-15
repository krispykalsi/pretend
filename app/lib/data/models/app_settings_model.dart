import 'dart:ui';
import 'package:pretend/domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel(
      {required bool firstTimeStartup, required Color? themeColor})
      : super(firstTimeStartup: firstTimeStartup, themeColor: themeColor);

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      firstTimeStartup: json[keyFirstTimeStartup] ?? true,
      themeColor:
          json[keyThemeColor] != null ? Color(json[keyThemeColor]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final appSettings = <String, dynamic>{};
    appSettings[keyFirstTimeStartup] = firstTimeStartup;
    appSettings[keyThemeColor] = themeColor?.value;
    return appSettings;
  }

  static const keyFirstTimeStartup = "first-time-startup";
  static const keyThemeColor = "theme-color";
}
