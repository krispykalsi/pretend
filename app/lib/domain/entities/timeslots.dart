import 'package:intl/intl.dart';

enum Timeslots {
  t8AM,
  t9AM,
  t10AM,
  t11AM,
  t12PM,
  t1PM,
  t2PM,
  t3PM,
  t4PM,
  t5PM,
  t6PM,
  t7PM,
}

Timeslots getTimeslotFromDashed(String dashed) {
  switch (dashed) {
    case "8-9":
      return Timeslots.t8AM;
    case "9-10":
      return Timeslots.t9AM;
    case "10-11":
      return Timeslots.t10AM;
    case "11-12":
      return Timeslots.t11AM;
    case "12-1":
      return Timeslots.t12PM;
    case "1-2":
      return Timeslots.t1PM;
    case "2-3":
      return Timeslots.t2PM;
    case "3-4":
      return Timeslots.t3PM;
    case "4-5":
      return Timeslots.t4PM;
    case "5-6":
      return Timeslots.t5PM;
    case "6-7":
      return Timeslots.t6PM;
    case "7-8":
      return Timeslots.t7PM;
    default:
      throw Exception("invalid dashed timeslot");
  }
}

enum _TimeslotHour { starting, ending }

extension ParseToString on Timeslots {
  String get dashed {
    switch (this) {
      case Timeslots.t8AM:
        return "8-9";
      case Timeslots.t9AM:
        return "9-10";
      case Timeslots.t10AM:
        return "10-11";
      case Timeslots.t11AM:
        return "11-12";
      case Timeslots.t12PM:
        return "12-1";
      case Timeslots.t1PM:
        return "1-2";
      case Timeslots.t2PM:
        return "2-3";
      case Timeslots.t3PM:
        return "3-4";
      case Timeslots.t4PM:
        return "4-5";
      case Timeslots.t5PM:
        return "5-6";
      case Timeslots.t6PM:
        return "6-7";
      case Timeslots.t7PM:
        return "7-8";
    }
  }

  String get startHour12 {
    return _convertToHour12(startHour24);
  }

  String get endHour12 {
    return _convertToHour12(endHour24);
  }

  String _extractHour12(_TimeslotHour part) {
    final regex = RegExp(r'(\d+)-(\d+)');
    final match = regex.firstMatch(dashed)!;
    late String slot;
    switch (part) {
      case _TimeslotHour.starting:
        slot = match.group(1)!;
        break;
      case _TimeslotHour.ending:
        slot = match.group(2)!;
        break;
    }
    return slot;
  }

  String _convertToHour12(int hour24) {
    if (hour24 < 12) {
      return "$hour24" + " AM";
    } else if (hour24 == 12) {
      return "$hour24" + " PM";
    } else {
      return "${hour24 - 12}" + " PM";
    }
  }
}

extension Comparison on Timeslots {
  int get startHour24 {
    final hour12 = int.parse(_extractHour12(_TimeslotHour.starting));
    return hour12 < 8 ? hour12 + 12 : hour12;
  }

  int get endHour24 {
    final hour12 = int.parse(_extractHour12(_TimeslotHour.ending));
    return hour12 < 9 ? hour12 + 12 : hour12;
  }

  int compareTo(Timeslots other) {
    return startHour24.compareTo(other.startHour24);
  }
}

extension MapperToDateTime on Timeslots {
  DateTime get startTime {
    return DateFormat("h a").parse(startHour12);
  }

  DateTime get endTime {
    return DateFormat("h a").parse(endHour12);
  }
}
