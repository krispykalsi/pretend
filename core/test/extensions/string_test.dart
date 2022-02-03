import 'package:core/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void _runContainsAnywhereTestOnEach(Iterable<String> testData, {required bool expectedResult}) {
  const tString = "Quick Brown Fox";

  for (final searchChars in testData) {
    test(searchChars, () {
      final isFound = tString.containsAnywhere(searchChars);
      expect(isFound, expectedResult);
    });
  }
}

void main() {
  group('should identify the test string with given input characters', () {
    const testData = [
      "qb",
      "Qb",
      "qB",
      "bf",
      "brf",
      "ur",
      "row",
      "OOX",
    ];
    _runContainsAnywhereTestOnEach(testData, expectedResult: true);
  });

  group('should NOT identify the test string with given input characters', () {
    const testData = [
      "fow",
      "a",
      "kc"
    ];
    _runContainsAnywhereTestOnEach(testData, expectedResult: false);
  });

  group('should abbreviate string with initials of each word', () {
    const testData = [
      Tuple2("Software Engineering", "SE"),
      Tuple2("Mathematics (Day)", "MD"),
      Tuple2("abC  De", "AD"),
      Tuple2("bruh", "B"),
      Tuple2("", ""),
      Tuple2("as# *(3fdj /:", "A3"),
    ];
    for (final data in testData) {
      test(data, () {
        final actual = data.value1.abbreviate();
        expect(actual, data.value2);
      });
    }
  });

  group('should capitalize each word in the string', () {
    const testData = [
      Tuple2("software engineering", "Software Engineering"),
      Tuple2("MATHMEthics (Day)", "Mathmethics (Day)"),
      Tuple2("abC  De o", "Abc  De O"),
      Tuple2("bruh", "Bruh"),
      Tuple2("", ""),
      Tuple2("as# *(3fdj /:", "As# *(3fdj /:"),
    ];
    for (final data in testData) {
      test(data, () {
        final actual = data.value1.toTitleCase();
        expect(actual, data.value2);
      });
    }
  });
}
