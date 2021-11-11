import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';

class MarkAppVisitedFirstTime extends UseCase<void, NoParams> {
  final SettingsRepositoryContract repo;

  MarkAppVisitedFirstTime(this.repo);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repo.setFirstTimeFlag();
  }
}
