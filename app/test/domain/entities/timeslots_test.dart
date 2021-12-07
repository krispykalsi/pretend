import 'package:flutter_test/flutter_test.dart';
import 'package:pretend/domain/entities/timeslots.dart';


void main() {
  group('should should correctly extract hour in 24hour format from Timeslot', () {
      group('startInt', () {
          for (var i = 0; i < Timeslots.values.length; ++i) {
            final hour24 = i + 8;
            test('${Timeslots.values[i]} -> $hour24', () {
              expect(Timeslots.values[i].startHour24, hour24);
            });
          }
      });

      group('endInt', () {
        for (var i = 0; i < Timeslots.values.length; ++i) {
          final hour24 = i + 9;
          test('${Timeslots.values[i]} -> $hour24', () {
            expect(Timeslots.values[i].endHour24, hour24);
          });
        }
      });
  });

  group('should correctly parse Timeslots to corresponding DateTime object', () {
    for (var slot in Timeslots.values) {
      group(slot.toString(), () {
        test('start', () {
          final actual = slot.startTime;
          expect(actual.hour, slot.startHour24);
          expect(actual.minute, 0);
        });

        test('end', () {
          final actual = slot.endTime;
          expect(actual.hour, slot.endHour24);
          expect(actual.minute, 0);
        });
      });
    }
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
