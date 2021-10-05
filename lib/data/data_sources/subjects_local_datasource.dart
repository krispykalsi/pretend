import 'package:hive/hive.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/data/data_sources/hive_datasource.dart';
import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsLocalDataSourceContract {
  Future<List<SubjectModel>> getAllSubjects();
  Future<Map<String, SubjectModel>> getSubjects(List<String> keys);
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
  Future<List<SubjectModel>> getAllSubjects() async {
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

  @override
  Future<Map<String, SubjectModel>> getSubjects(List<String> keys) async {
    try {
      final subjectBox = await openBox(_SUBJECTS);
      Map<String, SubjectModel> subjects = {};
      keys.forEach((subjectKey) {
        final subjectJson = subjectBox.get(subjectKey);
        subjects[subjectKey] = SubjectModel.fromJson(subjectJson);
      });
      return subjects;
    } catch (e) {
      throw CacheException();
    }
  }
}
