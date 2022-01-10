import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([String? msg]) : message = msg ?? "Unexpected error occurred";

  @override
  List<Object?> get props => [message];
}

class NoLocalDataFailure extends Failure {
  @override
  String get message => "No data found in local storage";
}

class NoRemoteDataFailure extends Failure {
  @override
  String get message => "No data found in online storage";
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

class FilterTimetableFailure extends Failure {
  FilterTimetableFailure(String msg) : super(msg);
}

class CollegeNotConfiguredFailure extends Failure {
  @override
  String get message => "College not selected";
}

class FileIOFailure extends Failure {
  const FileIOFailure(String msg) : super(msg);
}

class InvalidFileExtensionFailure extends Failure {
  const InvalidFileExtensionFailure(String ext)
      : super("Expected extension: .pretend.json\nGot: $ext");
}

class CorruptedDataFailure extends Failure {
  const CorruptedDataFailure(String msg, dynamic data)
      : super("Error: $msg\nData: $data");
}

class UserDeclinedNotificationAccessFailure extends Failure {
  const UserDeclinedNotificationAccessFailure();
}
