import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/features/timetable/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/features/timetable/data/models/timetable_model.dart';
import 'package:pretend/features/timetable/domain/repositories/timetable_repository_contract.dart';


class TimetableRepository implements TimetableRepositoryContract {
  final TimetableLocalDataSourceContract localDataSource;

  TimetableRepository(this.localDataSource);

  @override
  Future<Either<Failure, TimetableModel>> getTimetable() async {
    try {
      final timetable = await localDataSource.getTimetable();
      return Right(timetable);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTimetable(TimetableModel timetable) async {
    try {
      await localDataSource.setTimetable(timetable);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}