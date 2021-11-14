import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/entities/app_settings.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';

class GetAppSettings extends UseCase<AppSettings, NoParams> {
  final SettingsRepositoryContract repo;

  GetAppSettings(this.repo);

  @override
  Future<Either<Failure, AppSettings>> call(NoParams params) {
    return repo.getAppSettings();
  }
}
