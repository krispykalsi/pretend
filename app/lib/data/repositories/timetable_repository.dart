import 'package:dartz/dartz.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/timetable_local_datasource.dart';
import 'package:pretend/data/models/timetable_model.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';


class TimetableRepository implements TimetableRepositoryContract {
  final TimetableLocalDataSourceContract localDataSource;

  TimetableRepository(this.localDataSource);

  @override
  Future<Either<Failure, Timetable>> getTimetable() async {
    try {
      final timetable = await localDataSource.getTimetable();
      return Right(timetable);
    } on CacheException {
      return Left(CacheFailure());
    } on NoLocalDataException {
      return Left(NoLocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTimetable(Timetable timetable) async {
    try {
      await localDataSource.setTimetable(TimetableModel.fromEntity(timetable));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}