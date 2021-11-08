enum Timeslots {
  T8AM,
  T9AM,
  T10AM,
  T11AM,
  T12PM,
  T1PM,
  T2PM,
  T3PM,
  T4PM,
  T5PM,
  T6PM,
  T7PM,
}

Timeslots getTimeslotFromDashed(String dashed) {
  switch (dashed) {
    case "8-9":
      return Timeslots.T8AM;
    case "9-10":
      return Timeslots.T9AM;
    case "10-11":
      return Timeslots.T10AM;
    case "11-12":
      return Timeslots.T11AM;
    case "12-1":
      return Timeslots.T12PM;
    case "1-2":
      return Timeslots.T1PM;
    case "2-3":
      return Timeslots.T2PM;
    case "3-4":
      return Timeslots.T3PM;
    case "4-5":
      return Timeslots.T4PM;
    case "5-6":
      return Timeslots.T5PM;
    case "6-7":
      return Timeslots.T6PM;
    case "7-8":
      return Timeslots.T7PM;
    default:
      throw Exception("invalid dashed timeslot");
  }
}

extension ParseToString on Timeslots {
  String get dashed {
    switch (this) {
      case Timeslots.T8AM:
        return "8-9";
      case Timeslots.T9AM:
        return "9-10";
      case Timeslots.T10AM:
        return "10-11";
      case Timeslots.T11AM:
        return "11-12";
      case Timeslots.T12PM:
        return "12-1";
      case Timeslots.T1PM:
        return "1-2";
      case Timeslots.T2PM:
        return "2-3";
      case Timeslots.T3PM:
        return "3-4";
      case Timeslots.T4PM:
        return "4-5";
      case Timeslots.T5PM:
        return "5-6";
      case Timeslots.T6PM:
        return "6-7";
      case Timeslots.T7PM:
        return "7-8";
    }
  }

  String get start {
    return _appendMeridiem(_extractPart(1));
  }

  String get end {
    return _appendMeridiem(_extractPart(2));
  }

  String _extractPart(int part) {
    final regex = RegExp(r'(\d+)-(\d+)');
    final match = regex.firstMatch(dashed)!;
    final slot = match.group(part)!;
    return slot;
  }

  String _appendMeridiem(String slot) {
    final slotInt = int.parse(slot);
    if (slotInt > 7) {
      return slot + " AM";
    } else {
      return slot + " PM";
    }
  }
}

extension Comparison on Timeslots {
  int get integer {
    return int.parse(_extractPart(1));
  }

  int compareTo(Timeslots other) {
    var a = integer;
    var b = other.integer;

    if (a < 8) a += 12;
    if (b < 8) b += 12;
    return a.compareTo(b);
  }
}
