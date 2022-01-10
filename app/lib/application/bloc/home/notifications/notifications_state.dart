part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class Loading extends NotificationsState {
  const Loading();
}

class FetchSuccessful extends NotificationsState {
  final bool areNotificationsOn;

  const FetchSuccessful(this.areNotificationsOn);

  @override
  List<Object> get props => [areNotificationsOn];
}

class NotificationsOn extends NotificationsState {
  const NotificationsOn();
}

class NotificationOff extends NotificationsState {
  const NotificationOff();
}

class Failed extends NotificationsState {
  final String message;

  const Failed(this.message);

  @override
  List<Object> get props => [message];
}
