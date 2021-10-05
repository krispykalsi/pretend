import 'package:pretend/domain/entities/subject.dart';

class SubjectModelFields {
  static const NAME = 'name';
  static const CODE = 'code';
}

class SubjectModel extends Subject {
  const SubjectModel({required String name, required String code})
      : super(name, code);

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      name: json[SubjectModelFields.NAME],
      code: json[SubjectModelFields.CODE],
    );
  }

  static List<SubjectModel> listFromJson(List<dynamic> list) {
    List<SubjectModel> subjects = [];
    list.forEach((subject) {
      subjects.add(SubjectModel.fromJson(subject));
    });
    return subjects;
  }

  static Map<String, SubjectModel> mapFromJson(Map<String, dynamic> json) {
    Map<String, SubjectModel> subjects = {};
    for (String subjectKey in json.keys) {
      subjects[subjectKey] = SubjectModel.fromJson(json[subjectKey]);
    }
    return subjects;
  }

  Map<String, dynamic> toJson() {
    return {
      SubjectModelFields.NAME: name,
      SubjectModelFields.CODE: code
    };
  }
}
