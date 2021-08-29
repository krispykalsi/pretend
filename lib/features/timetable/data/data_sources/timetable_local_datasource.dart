import 'package:pretend/features/timetable/data/models/subject_model.dart';

abstract class TimetableLocalDataSource {
  Future<List<SubjectModel>> getSubjects();
  Future<void> clearDatabase();
  Future<void> addSubjects(List<SubjectModel> subjects);
  Future<void> addSubject(SubjectModel subjects);
}