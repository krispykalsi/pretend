import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';

class SetCollegeID extends UseCase<void, SetCollegeIDParams> {
  final SubjectsRepositoryContract repository;

  SetCollegeID(this.repository);

  @override
  Future<Either<Failure, void>> call(SetCollegeIDParams params) async {
    return await repository.setCollegeID(params.id);
  }
}

class SetCollegeIDParams extends Equatable {
  final String id;

  const SetCollegeIDParams(this.id);

  @override
  List<Object?> get props => [id];
}
