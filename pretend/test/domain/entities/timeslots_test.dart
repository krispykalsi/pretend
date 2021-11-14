import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/domain/entities/timeslots.dart';


void main() {
  group('should correctly parse Timeslots to corresponding DateTime object', () {
    Timeslots.values.forEach((slot) {
      group(slot.toString(), () {
        test('start', () {
          final actual = slot.startTime;
          expect(actual.hour, slot.startInt);
          expect(actual.minute, 0);
        });

        test('end', () {
          final actual = slot.endTime;
          expect(actual.hour, slot.endInt);
          expect(actual.minute, 0);
        });
      });
    });
  });

  group('should compare Timeslots correctly', () {
    for (var i = 0; i < Timeslots.values.length-1; ++i) {
      final current = Timeslots.values[i];
      final next = Timeslots.values[i+1];
      test('$current < $next', () {
        expect(current.compareTo(next), -1);
      });
    }
  });
}
