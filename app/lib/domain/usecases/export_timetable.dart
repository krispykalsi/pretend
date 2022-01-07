import 'package:core/src/error/failures.dart';
import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/services/file_handler_contract.dart';
import 'package:pretend/domain/services/pretend_dot_json_coder_contract.dart';

class ExportTimetable extends UseCase<String, ExportTimetableParams> {
  final FileHandlerContract _fileHandler;
  final PretendDotJsonCoderContract _pretendDotJsonCoder;

  ExportTimetable({
    required FileHandlerContract fileHandler,
    required PretendDotJsonCoderContract pretendDotJsonCoder,
  })  : _fileHandler = fileHandler,
        _pretendDotJsonCoder = pretendDotJsonCoder;

  @override
  Future<Either<Failure, String>> call(ExportTimetableParams params) async {
    final encodedEither = await _pretendDotJsonCoder.encode(params.tws);
    return await encodedEither.fold(
      (failure) => Left(failure),
      (file) async => await _fileHandler.getPath(file),
    );
  }
}

class ExportTimetableParams extends Equatable {
  final TimetableWithSubjects tws;

  const ExportTimetableParams(this.tws);

  @override
  List<Object> get props => [tws];
}
