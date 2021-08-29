import 'package:pretend/features/timetable/domain/entities/subject.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required String name,
    required String code
  }) : super(name, code);
}
