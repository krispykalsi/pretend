import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final String name;
  final String code;

  const Subject(this.name, this.code);

  @override
  List<Object?> get props => [name, code];
}