import 'package:hive/hive.dart';
import 'package:pretend/core/error/exceptions.dart';
import 'package:pretend/features/timetable/data/models/subject_model.dart';

abstract class SubjectsLocalDataSourceContract {
  Future<List<SubjectModel>> getSubjects();
  Future<void> clearSubjects();
  Future<void> addSubjects(List<SubjectModel> subjects);
  Future<void> addSubject(SubjectModel subject);
}

class HiveBoxKeys {
  static const SUBJECTS = 'subjects';
}

class SubjectsLocalDataSource implements SubjectsLocalDataSourceContract {
  final HiveInterface hive;

  SubjectsLocalDataSource({required this.hive});

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addSubject(SubjectModel subject) async {
    try {
      final subjectBox = await _openBox(HiveBoxKeys.SUBJECTS);
      subjectBox.add(subject.toJson());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addSubjects(List<SubjectModel> subjects) async {
    try {
      final subjectBox = await _openBox(HiveBoxKeys.SUBJECTS);
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
      final subjectBox = await _openBox(HiveBoxKeys.SUBJECTS);
      subjectBox.deleteFromDisk();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<SubjectModel>> getSubjects() async {
    try {
      final subjectBox = await _openBox(HiveBoxKeys.SUBJECTS);
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
