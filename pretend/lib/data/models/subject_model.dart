import 'package:pretend/domain/entities/subject.dart';

class SubjectModelFields {
  static const name = 'name';
  static const code = 'code';
}

class SubjectModel extends Subject {
  const SubjectModel({required String name, required String code})
      : super(name, code);

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      name: json[SubjectModelFields.name],
      code: json[SubjectModelFields.code],
    );
  }

  factory SubjectModel.fromEntity(Subject subject) {
    return SubjectModel(
      name: subject.name,
      code: subject.code,
    );
  }

  static List<SubjectModel> listFromJson(List<dynamic> list) {
    List<SubjectModel> subjects = [];
    for (final subject in list) {
      subjects.add(SubjectModel.fromJson(subject));
    }
    return subjects;
  }

  static Map<String, SubjectModel> mapFromJson(Map<String, dynamic> json) {
    Map<String, SubjectModel> subjects = {};
    for (String subjectCode in json.keys) {
      subjects[subjectCode] = SubjectModel.fromJson(json[subjectCode]);
    }
    return subjects;
  }

  Map<String, dynamic> toJson() {
    return {SubjectModelFields.name: name, SubjectModelFields.code: code};
  }
}
