import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/entities/college.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';


class GetColleges extends UseCase<List<College>, NoParams> {
  final SubjectsRepositoryContract repository;

  GetColleges(this.repository);

  @override
  Future<Either<Failure, List<College>>> call(NoParams params) async {
    return await repository.getColleges();
  }
}
