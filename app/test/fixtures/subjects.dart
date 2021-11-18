import 'package:pretend/data/models/subject_model.dart';

final _subjectModelList = [
  SubjectModel(name: "International Trade", code: "HU-351a"),
  SubjectModel(name: "Computer Networks", code: "IT-502"),
  SubjectModel(name: "Theory of Computing", code: "IT-504"),
];

List<SubjectModel> get getTestSubjectModels => _subjectModelList;
