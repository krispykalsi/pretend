// Mocks generated by Mockito 5.0.17 from annotations
// in pretend/test/application/bloc/home/home_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/error.dart' as _i5;
import 'package:core/usecase.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pretend/domain/entities/filters.dart' as _i9;
import 'package:pretend/domain/entities/timeslot.dart' as _i11;
import 'package:pretend/domain/entities/timeslots.dart' as _i10;
import 'package:pretend/domain/entities/timetable_with_subjects.dart' as _i6;
import 'package:pretend/domain/usecases/export_timetable.dart' as _i12;
import 'package:pretend/domain/usecases/filter_timetable.dart' as _i8;
import 'package:pretend/domain/usecases/get_timetable_with_subjects.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetTimetableWithSubjects].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTimetableWithSubjects extends _i1.Mock
    implements _i3.GetTimetableWithSubjects {
  MockGetTimetableWithSubjects() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TimetableWithSubjects>> call(
          _i7.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i2.Either<_i5.Failure, _i6.TimetableWithSubjects>>.value(
                  _FakeEither_0<_i5.Failure, _i6.TimetableWithSubjects>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.TimetableWithSubjects>>);
}

/// A class which mocks [FilterTimetable].
///
/// See the documentation for Mockito's code generation for more information.
class MockFilterTimetable extends _i1.Mock implements _i8.FilterTimetable {
  MockFilterTimetable() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, Map<_i9.Filters, Map<_i10.Timeslots, _i11.Timeslot>>>> call(
          _i8.FilterTimetableParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i2.Either<_i5.Failure, Map<_i9.Filters, Map<_i10.Timeslots, _i11.Timeslot>>>>.value(
              _FakeEither_0<_i5.Failure,
                  Map<_i9.Filters, Map<_i10.Timeslots, _i11.Timeslot>>>())) as _i4
          .Future<_i2.Either<_i5.Failure, Map<_i9.Filters, Map<_i10.Timeslots, _i11.Timeslot>>>>);
}

/// A class which mocks [ExportTimetable].
///
/// See the documentation for Mockito's code generation for more information.
class MockExportTimetable extends _i1.Mock implements _i12.ExportTimetable {
  MockExportTimetable() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> call(
          _i12.ExportTimetableParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
}
