import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

extension ModifiableDateTime on DateTime {
  DateTime updateByDate({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// If you'd look at the implementation, I've already filled the year and month.
  /// Chose the year 2021 and month 11 only because monday starts from day 1
  /// in this month, which will be aligned with the index of first weekday
  /// (monday, index - 1).
  ///
  /// (Could've taken any other year/month pair with a similar pattern)"
  ///
  /// So doing something like this will actually give the weekday that was requested:-
  /// ```dart
  ///  final nowModified = DateTime.now().updateByWeekday(DateTime.friday);
  ///  assert(nowModified.weekday == 5);
  ///  assert(nowModified.weekday == DateTime.friday);
  /// ```
  DateTime updateByWeekday({
    required int weekday,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      2021,
      11,
      weekday,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension TimeComparison on DateTime {
  int compareToTimeOnly(DateTime o) {
    final a = int.parse(sprintf("%02i%02i%02i", [hour, minute, second]));
    final b = int.parse(sprintf("%02i%02i%02i", [o.hour, o.minute, o.second]));
    return a.compareTo(b);
  }

  bool isTimeBefore(DateTime other) {
    return compareToTimeOnly(other) == -1;
  }

  bool isTimeAfter(DateTime other) {
    return compareToTimeOnly(other) == 1;
  }

  bool isTimeEqualTo(DateTime other) {
    return compareToTimeOnly(other) == 0;
  }
}

extension DateTimeStrings on DateTime {
  String get weekdayString => DateFormat.EEEE().format(this);

  String get monthString => DateFormat.MMMM().format(this);

  String get timeLeftFromNextHour {
    int minutes = 60 - this.minute;
    return sprintf("%02i min", [minutes]);
  }
}
