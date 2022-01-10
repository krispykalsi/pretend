import 'dart:io';

import 'package:core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:pretend/data/models/timetable_with_subjects_model.dart';
import 'package:pretend/data/services/json_coder.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/services/file_handler_contract.dart';
import 'package:pretend/domain/services/pretend_dot_json_coder_contract.dart';

class PretendDotJsonCoder implements PretendDotJsonCoderContract {
  final FileHandlerContract _fileHandler;
  final JsonCoderContract _jsonCoder;

  const PretendDotJsonCoder(this._fileHandler, this._jsonCoder);

  @override
  Future<Either<Failure, TimetableWithSubjects>> decode(File file) async {
    final nameEither = await _fileHandler.getName(file);
    return nameEither.fold(
      (failure) => Left(failure),
      (name) async {
        if (!name.endsWith(pretendDotJsonFileExtension)) {
          return Left(InvalidFileExtensionFailure(name));
        } else {
          var data = "";
          try {
            data = file.readAsStringSync();
            final twsJson = await _jsonCoder.decode(data);
            final tws = TimetableWithSubjectsModel.fromJson(twsJson);
            return Right(tws);
          } catch (e) {
            return Left(CorruptedDataFailure(e.toString(), data));
          }
        }
      },
    );
  }

  @override
  Future<Either<Failure, File>> encode(
      String name, TimetableWithSubjects tws) async {
    final twsJson = TimetableWithSubjectsModel.fromEntity(tws).toJson();
    final twsJsonString = await _jsonCoder.encode(twsJson);
    final filename = name + pretendDotJsonFileExtension;
    return await _fileHandler.writeNew(filename, twsJsonString);
  }

  static const pretendDotJsonFileExtension = ".pretend.json";
}
