import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';

class SetAppThemeColor extends UseCase<void, SetAppThemeColorParams> {
  final SettingsRepositoryContract repo;

  SetAppThemeColor(this.repo);

  @override
  Future<Either<Failure, void>> call(SetAppThemeColorParams params) {
    return repo.setThemeColor(params.color);
  }
}

class SetAppThemeColorParams extends Equatable {
  final Color color;

  const SetAppThemeColorParams(this.color);

  @override
  List<Object?> get props => [color];
}
