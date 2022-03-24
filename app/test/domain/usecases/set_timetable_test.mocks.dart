// Mocks generated by Mockito 5.0.17 from annotations
// in pretend/test/domain/usecases/set_timetable_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/error.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pretend/domain/entities/timetable.dart' as _i6;
import 'package:pretend/domain/repositories/timetable_repository_contract.dart'
    as _i3;
import 'package:pretend/domain/usecases/toggle_notifications.dart' as _i7;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [TimetableRepositoryContract].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimetableRepositoryContract extends _i1.Mock
    implements _i3.TimetableRepositoryContract {
  MockTimetableRepositoryContract() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Timetable>> getTimetable() =>
      (super.noSuchMethod(Invocation.method(#getTimetable, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Timetable>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Timetable>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Timetable>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> setTimetable(
          _i6.Timetable? timetable) =>
      (super.noSuchMethod(Invocation.method(#setTimetable, [timetable]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}

/// A class which mocks [ToggleNotifications].
///
/// See the documentation for Mockito's code generation for more information.
class MockToggleNotifications extends _i1.Mock
    implements _i7.ToggleNotifications {
  MockToggleNotifications() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> call(
          _i7.ToggleNotificationsParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
