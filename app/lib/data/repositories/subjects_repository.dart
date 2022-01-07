import 'package:core/error.dart';
import 'package:core/network.dart';
import 'package:dartz/dartz.dart';
import 'package:pretend/data/data_sources/subjects_local_datasource.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';
import 'package:pretend/data/models/subject_model.dart';
import 'package:pretend/domain/entities/college.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/repositories/subjects_repository_contract.dart';

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
  Future<Either<Failure, List<Subject>>> getSubjects(
      DataSource dataSource) async {
    switch (dataSource) {
      case DataSource.NETWORK:
        if (await networkInfo.isConnected) {
          try {
            final collegeID = await localDataSource.getCollegeID();
            if (collegeID == null) {
              return Left(CollegeNotConfiguredFailure());
            }
            final subjects = await remoteDataSource.getSubjects(collegeID);
            await localDataSource.addSubjects(subjects);
            return Right(subjects);
          } on ServerException {
            return Left(ServerFailure());
          } on CacheException {
            return Left(CacheFailure());
          }
        } else {
          return Left(NoInternetFailure());
        }

      case DataSource.LOCAL:
        try {
          final subjects = await localDataSource.getAllSubjects();
          return Right(subjects);
        } on NoLocalDataException {
          return Left(NoLocalDataFailure());
        } on CacheException {
          return Left(CacheFailure());
        }
    }
  }

  @override
  Future<Either<Failure, Map<String, Subject>>> getSubjectsFromKeys(
      List<String> keys) async {
    try {
      final subjectMap = await localDataSource.getSubjects(keys);
      return Right(subjectMap);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSubject(Subject subject) async {
    try {
      final subjectModel = SubjectModel.fromEntity(subject);
      await localDataSource.addSubject(subjectModel);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSubjects(Iterable<Subject> subjects) async {
    try {
      final subjectModels = subjects.map((sub) => SubjectModel.fromEntity(sub));
      await localDataSource.addSubjects(subjectModels);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setCollegeID(String id) async {
    try {
      await localDataSource.setCollegeID(id);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<College>>> getColleges() async {
    if (await networkInfo.isConnected) {
      try {
        final colleges = await remoteDataSource.getColleges();
        return Right(colleges);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
