import 'package:hive/hive.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/features/timetable/data/data_sources/hive_datasource.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';

abstract class SubjectsLocalDataSourceContract {
  Future<List<SubjectModel>> getSubjects();
  Future<void> clearSubjects();
  Future<void> addSubjects(List<SubjectModel> subjects);
  Future<void> addSubject(SubjectModel subject);
}

const _SUBJECTS = 'subjects';

class SubjectsLocalDataSource extends HiveDataSource implements SubjectsLocalDataSourceContract {
  SubjectsLocalDataSource({required HiveInterface hive}) : super(hive);

  @override
  Future<void> addSubject(SubjectModel subject) async {
    try {
      final subjectBox = await openBox(_SUBJECTS);
      subjectBox.add(subject.toJson());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addSubjects(List<SubjectModel> subjects) async {
    try {
      final subjectBox = await openBox(_SUBJECTS);
      subjects.forEach((subject) {
        subjectBox.add(subject.toJson());
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearSubjects() async {
    try {
      final subjectBox = await openBox(_SUBJECTS);
      subjectBox.deleteFromDisk();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<SubjectModel>> getSubjects() async {
    try {
      final subjectBox = await openBox(_SUBJECTS);
      List<SubjectModel> subjects = [];
      subjectBox.values.forEach((subjectJson) {
        subjects.add(SubjectModel.fromJson(subjectJson));
      });
      if (subjects.length == 0) {
        throw NoLocalDataException();
      } else {
        return subjects;
      }
    } on NoLocalDataException {
      throw NoLocalDataException();
    } catch (e) {
      throw CacheException();
    }
  }
}