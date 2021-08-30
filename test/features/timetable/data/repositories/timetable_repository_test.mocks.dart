// Mocks generated by Mockito 5.0.15 from annotations
// in pretend/test/features/timetable/data/repositories/timetable_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:pretend/features/timetable/data/data_sources/timetable_local_datasource.dart'
    as _i2;
import 'package:pretend/features/timetable/domain/entities/time_set.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [TimetableLocalDataSourceContract].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimetableLocalDataSourceContract extends _i1.Mock
    implements _i2.TimetableLocalDataSourceContract {
  MockTimetableLocalDataSourceContract() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, Map<int, _i4.TimeSet>>> getTimetable() =>
      (super.noSuchMethod(Invocation.method(#getTimetable, []),
              returnValue: Future<Map<String, Map<int, _i4.TimeSet>>>.value(
                  <String, Map<int, _i4.TimeSet>>{}))
          as _i3.Future<Map<String, Map<int, _i4.TimeSet>>>);
  @override
  _i3.Future<void> setTimetable(
          Map<String, Map<int, _i4.TimeSet>>? timetable) =>
      (super.noSuchMethod(Invocation.method(#setTimetable, [timetable]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}