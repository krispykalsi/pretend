import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';

class MarkAppVisitedFirstTime
    extends UseCase<void, MarkAppVisitedFirstTimeParams> {
  final SettingsRepositoryContract repo;

  MarkAppVisitedFirstTime(this.repo);

  @override
  Future<Either<Failure, void>> call(MarkAppVisitedFirstTimeParams params) {
    return repo.setFirstTimeFlag(params.flag);
  }
}

class MarkAppVisitedFirstTimeParams extends Equatable {
  final bool flag;

  const MarkAppVisitedFirstTimeParams(this.flag);

  @override
  List<Object?> get props => [flag];
}
