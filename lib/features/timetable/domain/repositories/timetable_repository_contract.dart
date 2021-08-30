import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/features/timetable/data/models/timetable_model.dart';

abstract class TimetableRepositoryContract {
  Future<Either<Failure, TimetableModel>> getTimetable();
  Future<Either<Failure, void>> setTimetable(TimetableModel timetable);
}