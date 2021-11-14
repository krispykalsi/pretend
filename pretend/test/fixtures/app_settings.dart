import 'dart:ui';
import 'package:pretend/data/models/app_settings_model.dart';
import 'package:pretend/domain/entities/app_settings.dart';

const _tAppSettings = AppSettings(
  firstTimeStartup: false,
  themeColor: Color(0xffffc2c2),
);

const _tAppSettingsModel = AppSettingsModel(
  firstTimeStartup: false,
  themeColor: Color(0xffffc2c2),
);

AppSettings get getTestAppSettings => _tAppSettings;

AppSettingsModel get getTestAppSettingsModel => _tAppSettingsModel;
