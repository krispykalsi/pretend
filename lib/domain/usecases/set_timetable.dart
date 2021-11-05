import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';

class SetTimetable extends UseCase<void, SetTimetableParams> {
  final TimetableRepositoryContract repository;

  SetTimetable(this.repository);

  @override
  Future<Either<Failure, void>> call(SetTimetableParams params) async {
    return await repository.setTimetable(params.timetable);
  }
}

class SetTimetableParams extends Equatable {
  final Timetable timetable;

  SetTimetableParams(this.timetable);

  @override
  List<Object?> get props => [timetable];
}