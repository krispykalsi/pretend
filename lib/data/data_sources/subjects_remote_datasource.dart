import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSourceContract {
  Future<List<SubjectModel>> getSubjects();
}