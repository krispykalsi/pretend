import 'package:flutter_test/flutter_test.dart';
import 'package:core/extensions.dart';

class _TestValues {
  final DateTime a;
  final DateTime b;
  final _is expectedComparison;

  _TestValues(this.a, this.expectedComparison, this.b);

  @override
  String toString() => "$a $expectedComparison $b";
}

class _Test2Values {
  final DateTime input;
  final String output;

  _Test2Values(this.input, this.output);

  String toString() => "$input -> $output";
}

enum _is {
  lessThan,
  greaterThan,
  equalTo,
}

void main() {
  group('should only consider hour, minute and second while comparison between two DateTime objects', () {
    [
      _TestValues(DateTime(2, 2, 2, 2, 2, 2), _is.lessThan, DateTime(1, 1, 1, 3, 3, 3)),
      _TestValues(DateTime(1, 1, 1, 2, 2, 2), _is.lessThan, DateTime(2, 2, 2, 3, 3, 3)),
      _TestValues(DateTime(1, 1, 1, 11, 5, 27), _is.lessThan, DateTime(2, 2, 2, 14, 0, 0)),
      _TestValues(DateTime(2, 2, 2), _is.equalTo, DateTime(2, 2, 2)),
      _TestValues(DateTime(1, 2, 3), _is.equalTo, DateTime(4, 5, 6)),
      _TestValues(DateTime(4, 5, 6), _is.equalTo, DateTime(1, 2, 3)),
      _TestValues(DateTime(4, 5, 6, 7, 8, 9), _is.equalTo, DateTime(1, 2, 3, 7, 8, 9)),
      _TestValues(DateTime(1, 1, 1, 23, 0, 0), _is.greaterThan, DateTime(2, 2, 2, 14, 15, 16)),
      _TestValues(DateTime(1, 1, 1, 2, 2, 2), _is.greaterThan, DateTime(2, 2, 2, 2, 1, 2)),
      _TestValues(DateTime(2, 2, 2, 2, 2, 2), _is.greaterThan, DateTime(1, 1, 1, 2, 1, 2)),
    ].forEach((value) {
      test("$value", () {
        switch(value.expectedComparison) {
          case _is.lessThan:
            expect(value.a.compareToTimeOnly(value.b), -1);
            break;
          case _is.greaterThan:
            expect(value.a.compareToTimeOnly(value.b), 1);
            break;
          case _is.equalTo:
            expect(value.a.compareToTimeOnly(value.b), 0);
            break;
        }
      });
    });
  });

  group('should return correct minutes left from the end of hour', () {
    final tData = [
      _Test2Values(DateTime(1, 1, 1, 12, 15), "45 min"),
      _Test2Values(DateTime(1, 1, 1, 2, 24), "36 min"),
      _Test2Values(DateTime(1, 1, 1, 4, 0), "60 min"),
      _Test2Values(DateTime(1, 1, 1, 1, 59), "01 min"),
      _Test2Values(DateTime(1, 1, 1, 9, 61), "59 min"),
      _Test2Values(DateTime(1, 1, 1, 8, 55), "05 min"),
    ];

    for (final data in tData) {
      test(data.toString(), () {
        final timeLeft = data.input.timeLeftFromNextHour;
        expect(timeLeft, data.output);
      });
    }
  });
}
