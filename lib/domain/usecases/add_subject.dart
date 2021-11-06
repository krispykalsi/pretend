import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';

class AddSubject extends UseCase<void, AddSubjectParams> {
  final SubjectsRepositoryContract repository;

  AddSubject(this.repository);

  @override
  Future<Either<Failure, void>> call(AddSubjectParams params) async {
    return await repository.addSubject(params.subject);
  }
}

class AddSubjectParams extends Equatable {
  final Subject subject;

  AddSubjectParams(this.subject);

  @override
  List<Object?> get props => [subject];
}
