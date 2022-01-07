import 'dart:io';

import 'package:core/error.dart';
import 'package:dartz/dartz.dart';

abstract class FileHandlerContract {
  Future<Either<Failure, File>> find(String contentUri);
  Future<Either<Failure, String>> getName(File file);
  Future<Either<Failure, String>> getPath(File file);
  Future<Either<Failure, File>> writeNew(String filename, String data);
}