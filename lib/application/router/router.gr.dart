// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../domain/entities/subject.dart' as _i6;
import '../../presentation/setup/subjects/setup_subjects_page.dart' as _i1;
import '../../presentation/setup/timetable/timeslot_grid_tile_state.dart'
    as _i7;
import '../../presentation/setup/timetable/timetable_setup_page.dart' as _i3;
import '../../presentation/setup/timetable/timetable_setup_status_page.dart'
    as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SetupSubjectsRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SetupSubjectsPage(),
          transitionsBuilder: _i4.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupStatusRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupStatusRouteArgs>();
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.TimetableSetupStatusPage(
              key: args.key, subjects: args.subjects),
          transitionsBuilder: _i4.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupRouteArgs>();
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.TimetableSetupPage(
              key: args.key,
              subject: args.subject,
              selectionState: args.selectionState),
          transitionsBuilder: _i4.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(SetupSubjectsRoute.name, path: '/'),
        _i4.RouteConfig(TimetableSetupStatusRoute.name,
            path: '/timetable-setup-status-page'),
        _i4.RouteConfig(TimetableSetupRoute.name, path: '/timetable-setup-page')
      ];
}

/// generated route for [_i1.SetupSubjectsPage]
class SetupSubjectsRoute extends _i4.PageRouteInfo<void> {
  const SetupSubjectsRoute() : super(name, path: '/');

  static const String name = 'SetupSubjectsRoute';
}

/// generated route for [_i2.TimetableSetupStatusPage]
class TimetableSetupStatusRoute
    extends _i4.PageRouteInfo<TimetableSetupStatusRouteArgs> {
  TimetableSetupStatusRoute({_i5.Key? key, required List<_i6.Subject> subjects})
      : super(name,
            path: '/timetable-setup-status-page',
            args: TimetableSetupStatusRouteArgs(key: key, subjects: subjects));

  static const String name = 'TimetableSetupStatusRoute';
}

class TimetableSetupStatusRouteArgs {
  const TimetableSetupStatusRouteArgs({this.key, required this.subjects});

  final _i5.Key? key;

  final List<_i6.Subject> subjects;
}

/// generated route for [_i3.TimetableSetupPage]
class TimetableSetupRoute extends _i4.PageRouteInfo<TimetableSetupRouteArgs> {
  TimetableSetupRoute(
      {_i5.Key? key,
      required _i6.Subject subject,
      Map<String, Map<String, _i7.TimeslotGridTileState>>? selectionState})
      : super(name,
            path: '/timetable-setup-page',
            args: TimetableSetupRouteArgs(
                key: key, subject: subject, selectionState: selectionState));

  static const String name = 'TimetableSetupRoute';
}

class TimetableSetupRouteArgs {
  const TimetableSetupRouteArgs(
      {this.key, required this.subject, this.selectionState});

  final _i5.Key? key;

  final _i6.Subject subject;

  final Map<String, Map<String, _i7.TimeslotGridTileState>>? selectionState;
}
