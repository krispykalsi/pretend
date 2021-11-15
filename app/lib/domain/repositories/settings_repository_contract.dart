import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:pretend/domain/entities/app_settings.dart';

abstract class SettingsRepositoryContract {
  Future<Either<Failure, AppSettings>> getAppSettings();
  Future<Either<Failure, void>> setFirstTimeFlag(bool flag);
  Future<Either<Failure, void>> setThemeColor(Color color);
}
