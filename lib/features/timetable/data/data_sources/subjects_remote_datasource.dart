import 'package:pretend/features/timetable/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSourceContract {
  Future<List<SubjectModel>> getSubjects();
}