import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:core/network.dart';
import 'package:pretend/domain/entities/college.dart';
import 'package:pretend/domain/entities/subject.dart';

abstract class SubjectsRepositoryContract {
  Future<Either<Failure, List<Subject>>> getSubjects(DataSource dataSource);
  Future<Either<Failure, List<College>>> getColleges();
  Future<Either<Failure, Map<String, Subject>>> getSubjectsFromKeys(List<String> keys);
  Future<Either<Failure, void>> addSubject(Subject subject);
  Future<Either<Failure, void>> addSubjects(Iterable<Subject> subjects);
  Future<Either<Failure, void>> setCollegeID(String id);
}