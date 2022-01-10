import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/data/models/app_settings_model.dart';
import 'package:pretend/domain/entities/app_settings.dart';

import '../../fixtures/app_settings.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final tAppSettingsModel = getTestAppSettingsModel;

  test('should be a subclass of AppSettings entity', () {
    expect(tAppSettingsModel, isA<AppSettings>());
  });

  test('should return a valid AppSettingsModel', () async {
    final Map<String, dynamic> jsonMap = fixture("notifications.json");
    final result = AppSettingsModel.fromJson(jsonMap);
    expect(result, tAppSettingsModel);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tAppSettingsModel.toJson();
    final expectedJsonMap = fixture("notifications.json");
    expect(result, expectedJsonMap);
  });
}
