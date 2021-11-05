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

  int get integer {
    return int.parse(_extractPart(1));
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

  int compareTo(Timeslots other) {
    var a = integer;
    var b = other.integer;

    if (a < 8) a += 12;
    if (b < 8) b += 12;
    return a.compareTo(b);
  }
}