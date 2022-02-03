import 'package:core/src/error/failures.dart';
import 'package:core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/repositories/settings_repository_contract.dart';
import 'package:pretend/domain/services/notification_service_contract.dart';
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart';

class ToggleNotifications extends UseCase<void, ToggleNotificationsParams> {
  final NotificationServiceContract _notificationService;
  final SettingsRepositoryContract _settingsRepo;
  final GetTimetableWithSubjects _getTimetableWithSubjects;

  ToggleNotifications(
    this._notificationService,
    this._settingsRepo,
    this._getTimetableWithSubjects,
  );

  @override
  Future<Either<Failure, void>> call(ToggleNotificationsParams params) async {
    final settingsEither = await _settingsRepo.getAppSettings();
    return settingsEither.fold(
      (failure) => Left(failure),
      (settings) async {
        switch (params.status) {
          case Notifications.REFRESH:
            return settings.showNotifications ? await _refresh() : Right(null);
          case Notifications.TOGGLE:
            return settings.showNotifications ? _turnOff() : _turnOn();
        }
      },
    );
  }

  Future<Either<Failure, void>> _turnOn() async {
    final turnedOnEither = await _notificationService.askAndTurnOn();
    return turnedOnEither.fold(
      (failure) => Left(failure),
      (_) => _scheduleNotifications(),
    );
  }

  Future<Either<Failure, void>> _scheduleNotifications() async {
    final timetableEither = await _getTimetableWithSubjects(NoParams());
    return timetableEither.fold(
      (failure) => Left(failure),
      (tws) async {
        final scheduledEither =
            await _notificationService.scheduleForEverySubject(tws);
        return scheduledEither.fold(
          (failure) => Left(failure),
          (_) => _settingsRepo.setNotificationStatus(true),
        );
      },
    );
  }

  Future<Either<Failure, void>> _turnOff() async {
    final turnedOffEither = await _notificationService.cancelAllSchedules();
    return turnedOffEither.fold(
      (failure) => Left(failure),
      (_) => _settingsRepo.setNotificationStatus(false),
    );
  }

  Future<Either<Failure, void>> _refresh() async {
    final cancelEither = await _notificationService.cancelAllSchedules();
    return cancelEither.fold(
      (failure) => Left(failure),
      (_) async {
        final timetableEither = await _getTimetableWithSubjects(NoParams());
        return timetableEither.fold(
          (failure) => Left(failure),
          (tws) => _notificationService.scheduleForEverySubject(tws),
        );
      },
    );
  }
}

enum Notifications { REFRESH, TOGGLE }

class ToggleNotificationsParams extends Equatable {
  final Notifications status;

  const ToggleNotificationsParams(this.status);

  @override
  List<Object?> get props => [];
}
