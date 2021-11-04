import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSourceContract {
  Future<List<SubjectModel>> getSubjects();
}

class SubjectsRemoteDataSource implements SubjectsRemoteDataSourceContract {
  @override
  Future<List<SubjectModel>> getSubjects() {
    final _subjects = const [
      SubjectModel(name: "Computer Networks", code: "IT-124"),
      SubjectModel(name: "Theory of Computing", code: "IT-128"),
      SubjectModel(name: "International Trade Very Long Subject Name", code: "HU-351a"),
    ];
    return Future.value(_subjects);
  }
}
