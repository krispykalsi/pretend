import 'package:pretend/domain/entities/college.dart';

class CollegeModel extends College {
  const CollegeModel(String id, String name, String city)
      : super(id, name, city);

  factory CollegeModel.fromCsv(Iterable<dynamic> list) {
    const id = 0;
    const name = 1;
    const city = 2;
    return CollegeModel(
      list.elementAt(id),
      list.elementAt(name),
      list.elementAt(city),
    );
  }
}
