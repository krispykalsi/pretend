import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/settings_local_datasource.dart';
import 'package:pretend/data/models/app_settings_model.dart';
import 'package:pretend/domain/entities/app_settings.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';

class SettingsRepository implements SettingsRepositoryContract {
  final SettingsLocalDatasourceContract _localDatasource;

  SettingsRepository(this._localDatasource);

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    try {
      final json = await _localDatasource.getAppSettings();
      return Right(AppSettingsModel.fromJson(json));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setFirstTimeFlag(bool flag) async {
    try {
      await _localDatasource.setFirstTimeFlag(flag);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setThemeColor(Color color) async {
    try {
      await _localDatasource.setThemeColor(color.value);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setNotificationStatus(bool flag) async {
    try {
      await _localDatasource.setNotificationStatus(flag);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
