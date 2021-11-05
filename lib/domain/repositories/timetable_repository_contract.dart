import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/domain/entities/timetable.dart';

abstract class TimetableRepositoryContract {
  Future<Either<Failure, Timetable>> getTimetable();
  Future<Either<Failure, void>> setTimetable(Timetable timetable);
}