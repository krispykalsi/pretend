import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/features/timetable/domain/entities/time_set.dart';

abstract class TimetableRepositoryContract {
  Future<Either<Failure, Map<int, TimeSet>>> getTimetable(String day);
}