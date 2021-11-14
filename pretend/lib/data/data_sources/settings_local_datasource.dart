import 'package:hive/hive.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/hive_datasource.dart';
import 'package:pretend/data/models/app_settings_model.dart';

abstract class SettingsLocalDatasourceContract {
  Future<Map<String, dynamic>> getAppSettings();

  Future<void> setFirstTimeFlag(bool flag);

  Future<void> setThemeColor(int color);
}

const _appSettings = "app-settings";

class SettingsLocalDatasource extends HiveDataSource
    implements SettingsLocalDatasourceContract {
  SettingsLocalDatasource(HiveInterface hive) : super(hive);

  @override
  Future<Map<String, dynamic>> getAppSettings() async {
    try {
      final box = await openBox(_appSettings);
      return box.toMap().cast();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setFirstTimeFlag(bool flag) async {
    try {
      final box = await openBox(_appSettings);
      await box.put(AppSettingsModel.keyFirstTimeStartup, flag);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setThemeColor(int color) async {
    try {
      final box = await openBox(_appSettings);
      await box.put(AppSettingsModel.keyThemeColor, color);
    } catch (e) {
      throw CacheException();
    }
  }
}
