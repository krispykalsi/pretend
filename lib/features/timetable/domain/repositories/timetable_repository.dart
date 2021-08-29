import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';

abstract class TimetableRepository {
  Future<Either<Failure, List<Subject>>> getSubjects(DataSource dataSource);
}