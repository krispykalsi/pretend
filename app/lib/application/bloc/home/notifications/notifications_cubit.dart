import 'package:bloc/bloc.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/usecases/get_app_settings.dart';
import 'package:pretend/domain/usecases/toggle_notifications.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetAppSettings _getAppSettings;
  final ToggleNotifications _toggleNotifications;

  bool _areNotificationsOn = false;

  NotificationsCubit(this._toggleNotifications, this._getAppSettings)
      : super(NotificationsInitial()) {
    _getNotificationStatus();
  }

  void _getNotificationStatus() async {
    final settingsEither = await _getAppSettings(NoParams());
    settingsEither.fold(
      (failure) => emit(Failed(failure.message)),
      (settings) {
        _areNotificationsOn = settings.showNotifications;
        _areNotificationsOn
            ? emit(const NotificationsOn())
            : emit(const NotificationOff());
      },
    );
  }

  void toggleNotificationStatus() async {
    if (state is Loading) return;
    emit(const Loading());
    final toggleEither = await _toggleNotifications(NoParams());
    toggleEither.fold(
      (failure) => emit(Failed(failure.message)),
      (_) {
        _areNotificationsOn = !_areNotificationsOn;
        _areNotificationsOn
            ? emit(const NotificationsOn())
            : emit(const NotificationOff());
      },
    );
  }
}
