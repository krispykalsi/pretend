// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../domain/entities/subject.dart' as _i7;
import '../../domain/entities/timeslots.dart' as _i9;
import '../../domain/entities/timetable.dart' as _i8;
import '../../presentation/home/home_page.dart' as _i1;
import '../../presentation/setup/subjects/setup_subjects_page.dart' as _i2;
import '../../presentation/setup/timetable/timeslot_grid_tile_state.dart'
    as _i10;
import '../../presentation/setup/timetable/timetable_setup_page.dart' as _i4;
import '../../presentation/setup/timetable/timetable_setup_status_page.dart'
    as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    SetupSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<SetupSubjectsRouteArgs>(
          orElse: () => const SetupSubjectsRouteArgs());
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.SetupSubjectsPage(
              key: args.key, selectedSubjects: args.selectedSubjects),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupStatusRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupStatusRouteArgs>();
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.TimetableSetupStatusPage(
              key: args.key,
              timetable: args.timetable,
              subjects: args.subjects),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupRouteArgs>();
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TimetableSetupPage(
              key: args.key,
              subject: args.subject,
              selectionState: args.selectionState),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomeRoute.name, path: '/'),
        _i5.RouteConfig(SetupSubjectsRoute.name, path: '/setup-subjects-page'),
        _i5.RouteConfig(TimetableSetupStatusRoute.name,
            path: '/timetable-setup-status-page'),
        _i5.RouteConfig(TimetableSetupRoute.name, path: '/timetable-setup-page')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.SetupSubjectsPage]
class SetupSubjectsRoute extends _i5.PageRouteInfo<SetupSubjectsRouteArgs> {
  SetupSubjectsRoute(
      {_i6.Key? key, List<_i7.Subject> selectedSubjects = const []})
      : super(name,
            path: '/setup-subjects-page',
            args: SetupSubjectsRouteArgs(
                key: key, selectedSubjects: selectedSubjects));

  static const String name = 'SetupSubjectsRoute';
}

class SetupSubjectsRouteArgs {
  const SetupSubjectsRouteArgs({this.key, this.selectedSubjects = const []});

  final _i6.Key? key;

  final List<_i7.Subject> selectedSubjects;
}

/// generated route for [_i3.TimetableSetupStatusPage]
class TimetableSetupStatusRoute
    extends _i5.PageRouteInfo<TimetableSetupStatusRouteArgs> {
  TimetableSetupStatusRoute(
      {_i6.Key? key,
      _i8.Timetable? timetable,
      required List<_i7.Subject> subjects})
      : super(name,
            path: '/timetable-setup-status-page',
            args: TimetableSetupStatusRouteArgs(
                key: key, timetable: timetable, subjects: subjects));

  static const String name = 'TimetableSetupStatusRoute';
}

class TimetableSetupStatusRouteArgs {
  const TimetableSetupStatusRouteArgs(
      {this.key, this.timetable, required this.subjects});

  final _i6.Key? key;

  final _i8.Timetable? timetable;

  final List<_i7.Subject> subjects;
}

/// generated route for [_i4.TimetableSetupPage]
class TimetableSetupRoute extends _i5.PageRouteInfo<TimetableSetupRouteArgs> {
  TimetableSetupRoute(
      {_i6.Key? key,
      required _i7.Subject subject,
      Map<String, Map<_i9.Timeslots, _i10.TimeslotGridTileState>>?
          selectionState})
      : super(name,
            path: '/timetable-setup-page',
            args: TimetableSetupRouteArgs(
                key: key, subject: subject, selectionState: selectionState));

  static const String name = 'TimetableSetupRoute';
}

class TimetableSetupRouteArgs {
  const TimetableSetupRouteArgs(
      {this.key, required this.subject, this.selectionState});

  final _i6.Key? key;

  final _i7.Subject subject;

  final Map<String, Map<_i9.Timeslots, _i10.TimeslotGridTileState>>?
      selectionState;
}
