import 'package:equatable/equatable.dart';

class College extends Equatable {
  final String id;
  final String name;
  final String city;

  const College(this.id, this.name, this.city);

  @override
  List<Object?> get props => [id, name, city];
}
