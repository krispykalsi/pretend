import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/domain/entities/app_settings.dart';

abstract class SettingsRepositoryContract {
  Future<Either<Failure, AppSettings>> getAppSettings();
  Future<Either<Failure, void>> setFirstTimeFlag();
  Future<Either<Failure, void>> setThemeColor(Color color);
}
