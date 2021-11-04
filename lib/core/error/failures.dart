import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class NoLocalDataFailure extends Failure {}
class NoInternetFailure extends Failure {}
class ServerFailure extends Failure {}
class CacheFailure extends Failure {}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String UNEXPECTED_FAILURE_MESSAGE = 'Unexpected error occurred';
