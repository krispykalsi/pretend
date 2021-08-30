import 'package:dartz/dartz.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/core/error/failures.dart';
import 'package:pretend/core/network/data_source_enum.dart';
import 'package:pretend/core/network/network_info.dart';
import 'package:pretend/features/timetable/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/features/timetable/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/features/timetable/domain/entities/subject.dart';
import 'package:pretend/features/timetable/domain/repositories/subjects_repository_contract.dart';

class SubjectsRepository implements SubjectsRepositoryContract {
  final SubjectsLocalDataSourceContract localDataSource;
  final SubjectsRemoteDataSourceContract remoteDataSource;
  final NetworkInfo networkInfo;

  SubjectsRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Subject>>> getSubjects(DataSource dataSource) async {
    switch (dataSource) {
      case DataSource.NETWORK:
        if (await networkInfo.isConnected) {
          try {
            final subjects = await remoteDataSource.getSubjects();
            return Right(subjects);
          } on ServerException {
            return Left(ServerFailure());
          }
        } else {
          return Left(NoInternetFailure());
        }

      case DataSource.LOCAL:
        try {
          final subjects = await localDataSource.getSubjects();
          return Right(subjects);
        } on NoLocalDataException {
          return Left(NoLocalDataFailure());
        } on CacheException {
          return Left(CacheFailure());
        }
    }
  }
}
