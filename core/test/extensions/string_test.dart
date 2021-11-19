import 'package:core/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void _runTestOnEach(Iterable<String> testData, {required bool expectedResult}) {
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
    _runTestOnEach(testData, expectedResult: true);
  });

  group('should NOT identify the test string with given input characters', () {
    const testData = [
      "fow",
      "a",
      "kc"
    ];

    _runTestOnEach(testData, expectedResult: false);
  });
}
