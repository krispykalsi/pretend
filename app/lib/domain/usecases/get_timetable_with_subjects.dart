import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';

class GetTimetableWithSubjects
    extends UseCase<TimetableWithSubjects, NoParams> {
  final TimetableRepositoryContract _timetableRepo;
  final SubjectsRepositoryContract _subjectsRepo;

  GetTimetableWithSubjects(this._timetableRepo, this._subjectsRepo);

  @override
  Future<Either<Failure, TimetableWithSubjects>> call(NoParams params) async {
    final timetableEither = await _timetableRepo.getTimetable();
    return timetableEither.fold((failure) => Left(failure), (timetable) async {
      final subjectsEither =
          await _getSubjectsOfTimetable(timetable.subjectCodes);
      return subjectsEither.fold((failure) => Left(failure), (subjects) {
        return Right(TimetableWithSubjects(timetable, subjects));
      });
    });
  }

  Future<Either<Failure, Map<String, Subject>>> _getSubjectsOfTimetable(
      List<String> subjectCodes) async {
    return await _subjectsRepo.getSubjectsFromKeys(subjectCodes);
  }
}
