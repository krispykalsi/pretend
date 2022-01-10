import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:core/error.dart';
import 'package:core/src/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:pretend/domain/entities/days.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timeslots.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/services/notification_service_contract.dart';

class NotificationService implements NotificationServiceContract {
  final AwesomeNotifications _awesomeNotifications;

  NotificationService(this._awesomeNotifications);

  @override
  Future<Either<Failure, void>> askAndTurnOn() async {
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      final didUserAllow =
          await _awesomeNotifications.requestPermissionToSendNotifications();
      return didUserAllow
          ? Right(null)
          : Left(const UserDeclinedNotificationAccessFailure());
    } else {
      return Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> scheduleForEverySubject(
      TimetableWithSubjects tws) async {
    for (final timetable in tws.timetable.timetable.entries) {
      final weekday = Days.weekday(timetable.key);
      final timeslots = timetable.value.values.toList(growable: false)
        ..sort((a, b) => a.compareTo(b));
      for (var i = 1; i < timeslots.length; i++) {
        if (timeslots[i].isAdjacentTo(timeslots[i - 1])) {
          continue;
        }
        final subject = tws.subjects[timeslots[i].subjectCode]!;
        await _scheduleNotification(
          weekday,
          timeslots[i].slot.startTime,
          subject,
        );
      }
      if (timeslots.length > 0) {
        final subject = tws.subjects[timeslots[0].subjectCode]!;
        await _scheduleNotification(
          weekday,
          timeslots[0].slot.startTime,
          subject,
        );
      }
    }
    return Right(null);
  }

  @override
  Future<Either<Failure, void>> cancelAllSchedules() async {
    _awesomeNotifications.cancelAll();
    return Right(null);
  }

  Future<void> _scheduleNotification(
      int weekday, DateTime time, Subject subject) async {
    final fiveMinutesBeforeTime = time.subtract(const Duration(minutes: 5));
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: int.parse("$weekday${time.hour}${time.minute}"),
        channelKey: 'default_channel',
        title: "Your class is about to start",
        body: "${subject.name} @ ${time.hour}",
        wakeUpScreen: true,
        category: NotificationCategory.Alarm
      ),
      schedule: NotificationCalendar(
        weekday: weekday,
        hour: fiveMinutesBeforeTime.hour,
        minute: fiveMinutesBeforeTime.minute - 5,
        second: fiveMinutesBeforeTime.second,
        millisecond: fiveMinutesBeforeTime.millisecond,
        repeats: true,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );
  }
}
