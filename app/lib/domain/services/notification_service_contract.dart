import 'package:core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';

abstract class NotificationServiceContract {
  Future<Either<Failure, void>> askAndTurnOn();
  Future<Either<Failure, void>> cancelAllSchedules();
  Future<Either<Failure, void>> scheduleForEverySubject(TimetableWithSubjects tws);
}