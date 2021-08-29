import 'package:pretend/features/timetable/data/models/subject_model.dart';

abstract class TimetableRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
}