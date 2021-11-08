import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure([String? msg]) : message = msg ?? "Unexpected error occurred";

  @override
  List<Object?> get props => [message];
}

class NoLocalDataFailure extends Failure {
  @override
  String get message => "No data found in local storage";
}

class NoInternetFailure extends Failure {
  @override
  String get message => "No internet connectivity found";
}

class ServerFailure extends Failure {
  @override
  String get message => "Server Failure";
}

class CacheFailure extends Failure {
  @override
  String get message => "Cache Failure";
}

class GenerateScheduleFailure extends Failure {
  GenerateScheduleFailure(String msg) : super(msg);
}
