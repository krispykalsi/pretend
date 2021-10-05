import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/domain/entities/subject.dart';

abstract class SubjectsRepositoryContract {
  Future<Either<Failure, List<Subject>>> getSubjects(DataSource dataSource);
  Future<Either<Failure, Map<String, Subject>>> getSubjectsFromKeys(List<String> keys);
}