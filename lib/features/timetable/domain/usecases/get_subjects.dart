import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';
import 'package:pretend/features/timetable/domain/repositories/subjects_repository_contract.dart';


class GetSubjects extends UseCase<List<Subject>, GetSubjectsParams> {
  final SubjectsRepositoryContract repository;

  GetSubjects(this.repository);

  @override
  Future<Either<Failure, List<Subject>>> call(GetSubjectsParams params) async {
    return await repository.getSubjects(params.dataSource);
  }
}

class GetSubjectsParams extends Equatable {
  final DataSource dataSource;

  GetSubjectsParams(this.dataSource);

  @override
  List<Object?> get props => [dataSource];
}