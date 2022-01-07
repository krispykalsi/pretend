import 'package:core/src/error/failures.dart';
import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/services/file_handler_contract.dart';
import 'package:pretend/domain/services/pretend_dot_json_coder_contract.dart';

class ImportTimetable extends UseCase<TimetableWithSubjects, ImportTimetableParams> {
  final FileHandlerContract _fileHandler;
  final PretendDotJsonCoderContract _pretendDotJsonCoder;
  final SubjectsRepositoryContract _subjectsRepo;
  final TimetableRepositoryContract _timetableRepo;

  ImportTimetable({
    required FileHandlerContract fileHandler,
    required PretendDotJsonCoderContract pretendDotJsonCoder,
    required SubjectsRepositoryContract subjectsRepo,
    required TimetableRepositoryContract timetableRepo,
  })  : _fileHandler = fileHandler,
        _pretendDotJsonCoder = pretendDotJsonCoder,
        _subjectsRepo = subjectsRepo,
        _timetableRepo = timetableRepo;

  @override
  Future<Either<Failure, TimetableWithSubjects>> call(ImportTimetableParams params) async {
    final fileEither = await _fileHandler.find(params.contentUri);
    return await fileEither.fold(
      (failure) => Left(failure),
      (file) async {
        final timetableEither = await _pretendDotJsonCoder.decode(file);
        return await timetableEither.fold(
          (failure) => Left(failure),
          (timetableWithSubjects) async {
            final savedEither = await _saveToDatabase(timetableWithSubjects);
            return savedEither.fold(
              (failure) => Left(failure),
              (_) => timetableEither,
            );
          },
        );
      },
    );
  }

  Future<Either<Failure, void>> _saveToDatabase(TimetableWithSubjects tws) async {
    final subjects = tws.subjects.values;
    final addedEither = await _subjectsRepo.addSubjects(subjects);
    return addedEither.fold(
      (failure) => Left(failure),
      (_) async => await _timetableRepo.setTimetable(tws.timetable),
    );
  }
}

class ImportTimetableParams extends Equatable {
  final String contentUri;

  const ImportTimetableParams(this.contentUri);

  @override
  List<Object> get props => [contentUri];
}
