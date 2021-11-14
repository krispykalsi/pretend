import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/settings_local_datasource.dart';
import 'package:pretend/data/repositories/settings_repository.dart';

import '../../fixtures/app_settings.dart';
import '../../fixtures/fixture_reader.dart';
import 'settings_repository_test.mocks.dart';

@GenerateMocks([SettingsLocalDatasourceContract])
void main() {
  late MockSettingsLocalDatasourceContract mockDatasource;
  late SettingsRepository repo;

  setUp(() {
    mockDatasource = MockSettingsLocalDatasourceContract();
    repo = SettingsRepository(mockDatasource);
  });

  group('get all app settings', () {
    test('should return valid data from local datasource', () async {
      final tAppSettingsModel = getTestAppSettingsModel;
      final Map<String, dynamic> tAppSettingsJson =
          fixture('app_settings.json');
      when(mockDatasource.getAppSettings())
          .thenAnswer((_) => Future.value(tAppSettingsJson));
      final actual = await repo.getAppSettings();
      verify(mockDatasource.getAppSettings());
      expect(actual, Right(tAppSettingsModel));
    });

    test('should return CacheFailure on CacheException from local datasource',
        () async {
      when(mockDatasource.getAppSettings()).thenThrow(CacheException());
      final actual = await repo.getAppSettings();
      verify(mockDatasource.getAppSettings());
      expect(actual, Left(CacheFailure()));
    });
  });

  group('set first time flag', () {
    const tFlag = true;
    test('should call datasource to set first time flag', () async {
      when(mockDatasource.setFirstTimeFlag(tFlag))
          .thenAnswer((_) => Future.value(null));
      final actual = await repo.setFirstTimeFlag(tFlag);
      verify(mockDatasource.setFirstTimeFlag(tFlag));
      expect(actual, const Right(null));
    });

    test('should return CacheFailure on CacheException from local datasource',
        () async {
      when(mockDatasource.setFirstTimeFlag(tFlag)).thenThrow(CacheException());
      final actual = await repo.setFirstTimeFlag(tFlag);
      verify(mockDatasource.setFirstTimeFlag(tFlag));
      expect(actual, Left(CacheFailure()));
    });
  });

  group('set app theme color', () {
    const tColorValue = 0x123;
    const tColor = Color(tColorValue);
    test('should call datasource to set app theme color', () async {
      when(mockDatasource.setThemeColor(tColorValue))
          .thenAnswer((_) => Future.value(null));
      final actual = await repo.setThemeColor(tColor);
      verify(mockDatasource.setThemeColor(tColorValue));
      expect(actual, const Right(null));
    });

    test('should return CacheFailure on CacheException from local datasource',
        () async {
      when(mockDatasource.setThemeColor(any)).thenThrow(CacheException());
      final actual = await repo.setThemeColor(tColor);
      verify(mockDatasource.setThemeColor(tColorValue));
      expect(actual, Left(CacheFailure()));
    });
  });
}
