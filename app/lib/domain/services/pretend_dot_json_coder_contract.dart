import 'dart:io';

import 'package:core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';

abstract class PretendDotJsonCoderContract {
  Future<Either<Failure, File>> encode(String name, TimetableWithSubjects tws);
  Future<Either<Failure, TimetableWithSubjects>> decode(File file);
}
