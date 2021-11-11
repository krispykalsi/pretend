import 'dart:ui';
import 'package:pretend/domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel(
      {required bool firstTimeStartup, required Color themeColor})
      : super(firstTimeStartup: firstTimeStartup, themeColor: themeColor);

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      firstTimeStartup: json[KEY_FIRST_TIME_STARTUP],
      themeColor: Color(json[KEY_THEME_COLOR]),
    );
  }

  Map<String, dynamic> toJson() {
    final appSettings = Map<String, dynamic>();
    appSettings[KEY_FIRST_TIME_STARTUP] = firstTimeStartup;
    appSettings[KEY_THEME_COLOR] = themeColor.value;
    return appSettings;
  }

  static const KEY_FIRST_TIME_STARTUP = "first-time-startup";
  static const KEY_THEME_COLOR = "theme-color";
}
