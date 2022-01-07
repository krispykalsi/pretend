import 'dart:io';

import 'package:core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:pretend/domain/services/file_handler_contract.dart';

class FileHandler implements FileHandlerContract {
  final Future<File> Function(String) _toFile;
  final Future<Directory> Function() _getApplicationDocumentsDirectory;

  const FileHandler(this._toFile, this._getApplicationDocumentsDirectory);

  @override
  Future<Either<Failure, File>> find(String contentUri) async {
    try {
      final file = await _toFile(contentUri);
      return Right(file);
    } catch (e) {
      return Left(FileIOFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getName(File file) async {
    try {
      final name = file.path.substring(
        (file.path.lastIndexOf(Platform.pathSeparator)) + 1,
      );
      return Right(name);
    } catch (e) {
      return Left(FileIOFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPath(File file) async {
    try {
      return Right(file.absolute.path);
    } catch (e) {
      return Left(FileIOFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> writeNew(String filename, String data) async {
    try {
      final directory = await _getApplicationDocumentsDirectory();
      final path = join(directory.path, filename);
      final file = File(path);
      await file.writeAsString(data);
      return Right(file);
    } catch (e) {
      return Left(FileIOFailure(e.toString()));
    }
  }
}
