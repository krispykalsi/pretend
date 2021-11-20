import 'package:hive/hive.dart';
import 'package:core/error.dart';
import 'package:pretend/data/data_sources/hive_datasource.dart';
import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsLocalDataSourceContract {
  Future<List<SubjectModel>> getAllSubjects();
  Future<Map<String, SubjectModel>> getSubjects(List<String> keys);
  Future<void> clearSubjects();
  Future<void> addSubjects(List<SubjectModel> subjects);
  Future<void> addSubject(SubjectModel subject);
  Future<String?> getCollegeID();
  Future<void> setCollegeID(String id);
}

const _subjects = 'subjects';
const _keyCollegeID = 'collegeID';

class SubjectsLocalDataSource extends HiveDataSource implements SubjectsLocalDataSourceContract {
  SubjectsLocalDataSource({required HiveInterface hive}) : super(hive);

  @override
  Future<void> addSubject(SubjectModel subject) async {
    try {
      final subjectBox = await openBox(_subjects);
      subjectBox.put(subject.code, subject.toJson());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addSubjects(List<SubjectModel> subjects) async {
    try {
      final subjectBox = await openBox(_subjects);
      for (final subject in subjects) {
        await subjectBox.put(subject.code, subject.toJson());
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearSubjects() async {
    try {
      final subjectBox = await openBox(_subjects);
      subjectBox.deleteFromDisk();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<SubjectModel>> getAllSubjects() async {
    try {
      final subjectBox = await openBox(_subjects);
      List<SubjectModel> subjects = [];
      for (final subjectJson in subjectBox.values) {
        if (subjectJson is Map) {
          subjects.add(SubjectModel.fromJson(Map.from(subjectJson)));
        }
      }
      if (subjects.isEmpty) {
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
      final subjectBox = await openBox(_subjects);
      Map<String, SubjectModel> subjects = {};
      for (final subjectCode in keys) {
        final subjectDynamic = subjectBox.get(subjectCode);
        final subjectJson = Map<String, dynamic>.from(subjectDynamic);
        subjects[subjectCode] = SubjectModel.fromJson(subjectJson);
      }
      return subjects;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String?> getCollegeID() async {
    try {
      final subjectBox = await openBox(_subjects);
      return subjectBox.get(_keyCollegeID);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setCollegeID(String id) async {
    try {
      final subjectBox = await openBox(_subjects);
      return subjectBox.put(_keyCollegeID, id);
    } catch (e) {
      throw CacheException();
    }
  }
}
