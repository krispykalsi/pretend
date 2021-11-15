import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';

class GetSubjectsOfTimetable
    extends UseCase<Map<String, Subject>, GetSubjectsOfTimetableParams> {
  final SubjectsRepositoryContract repository;

  GetSubjectsOfTimetable(this.repository);

  @override
  Future<Either<Failure, Map<String, Subject>>> call(
      GetSubjectsOfTimetableParams params) async {
    return await repository.getSubjectsFromKeys(params.subjectCodes);
  }
}

class GetSubjectsOfTimetableParams extends Equatable {
  final List<String> subjectCodes;

  const GetSubjectsOfTimetableParams(this.subjectCodes);

  @override
  List<Object?> get props => [subjectCodes];
}
