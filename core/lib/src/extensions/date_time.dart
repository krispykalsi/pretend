import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

extension ModifiableDateTime on DateTime {
  DateTime update({
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
}
