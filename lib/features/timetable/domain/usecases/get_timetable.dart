import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository_contract.dart';


class GetTimetable extends UseCase<Map<int, TimeSet>, GetTimetableParams> {
  final TimetableRepositoryContract repository;

  GetTimetable(this.repository);

  @override
  Future<Either<Failure, Map<int, TimeSet>>> call(GetTimetableParams params) async {
    return await repository.getTimetable(params.day);
  }
}

class GetTimetableParams extends Equatable {
  final String day;

  GetTimetableParams(this.day);

  @override
  List<Object?> get props => [day];
}