import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository.dart';


class GetSubjects extends UseCase<List<Subject>, Params> {
  final TimetableRepository repository;

  GetSubjects(this.repository);

  @override
  Future<Either<Failure, List<Subject>>> call(Params params) async {
    return await repository.getSubjects(params.dataSource);
  }
}

class Params extends Equatable {
  final DataSource dataSource;

  Params(this.dataSource);

  @override
  List<Object?> get props => [dataSource];
}