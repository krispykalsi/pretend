// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../domain/entities/subject.dart' as _i8;
import '../../domain/entities/timeslots.dart' as _i10;
import '../../domain/entities/timetable.dart' as _i9;
import '../../presentation/home/home_page.dart' as _i1;
import '../../presentation/initial/initial_page.dart' as _i5;
import '../../presentation/setup/subjects/setup_subjects_page.dart' as _i2;
import '../../presentation/setup/timetable/timeslot_grid_tile_state.dart'
    as _i11;
import '../../presentation/setup/timetable/timetable_setup_page.dart' as _i4;
import '../../presentation/setup/timetable/timetable_setup_status_page.dart'
    as _i3;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i6.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    SetupSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<SetupSubjectsRouteArgs>(
          orElse: () => const SetupSubjectsRouteArgs());
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.SetupSubjectsPage(
              key: args.key, selectedSubjects: args.selectedSubjects),
          transitionsBuilder: _i6.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupStatusRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupStatusRouteArgs>();
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.TimetableSetupStatusPage(
              key: args.key,
              timetable: args.timetable,
              subjects: args.subjects),
          transitionsBuilder: _i6.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupRouteArgs>();
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TimetableSetupPage(
              key: args.key,
              subject: args.subject,
              selectionState: args.selectionState),
          transitionsBuilder: _i6.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    InitialRoute.name: (routeData) {
      final args = routeData.argsAs<InitialRouteArgs>(
          orElse: () => const InitialRouteArgs());
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i5.InitialPage(key: args.key),
          transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i6.RouteConfig(SetupSubjectsRoute.name, path: '/setup-subjects-page'),
        _i6.RouteConfig(TimetableSetupStatusRoute.name,
            path: '/timetable-setup-status-page'),
        _i6.RouteConfig(TimetableSetupRoute.name,
            path: '/timetable-setup-page'),
        _i6.RouteConfig(InitialRoute.name, path: '/')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.SetupSubjectsPage]
class SetupSubjectsRoute extends _i6.PageRouteInfo<SetupSubjectsRouteArgs> {
  SetupSubjectsRoute(
      {_i7.Key? key, List<_i8.Subject> selectedSubjects = const []})
      : super(name,
            path: '/setup-subjects-page',
            args: SetupSubjectsRouteArgs(
                key: key, selectedSubjects: selectedSubjects));

  static const String name = 'SetupSubjectsRoute';
}

class SetupSubjectsRouteArgs {
  const SetupSubjectsRouteArgs({this.key, this.selectedSubjects = const []});

  final _i7.Key? key;

  final List<_i8.Subject> selectedSubjects;
}

/// generated route for [_i3.TimetableSetupStatusPage]
class TimetableSetupStatusRoute
    extends _i6.PageRouteInfo<TimetableSetupStatusRouteArgs> {
  TimetableSetupStatusRoute(
      {_i7.Key? key,
      _i9.Timetable? timetable,
      required List<_i8.Subject> subjects})
      : super(name,
            path: '/timetable-setup-status-page',
            args: TimetableSetupStatusRouteArgs(
                key: key, timetable: timetable, subjects: subjects));

  static const String name = 'TimetableSetupStatusRoute';
}

class TimetableSetupStatusRouteArgs {
  const TimetableSetupStatusRouteArgs(
      {this.key, this.timetable, required this.subjects});

  final _i7.Key? key;

  final _i9.Timetable? timetable;

  final List<_i8.Subject> subjects;
}

/// generated route for [_i4.TimetableSetupPage]
class TimetableSetupRoute extends _i6.PageRouteInfo<TimetableSetupRouteArgs> {
  TimetableSetupRoute(
      {_i7.Key? key,
      required _i8.Subject subject,
      Map<String, Map<_i10.Timeslots, _i11.TimeslotGridTileState>>?
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

  final _i7.Key? key;

  final _i8.Subject subject;

  final Map<String, Map<_i10.Timeslots, _i11.TimeslotGridTileState>>?
      selectionState;
}

/// generated route for [_i5.InitialPage]
class InitialRoute extends _i6.PageRouteInfo<InitialRouteArgs> {
  InitialRoute({_i7.Key? key})
      : super(name, path: '/', args: InitialRouteArgs(key: key));

  static const String name = 'InitialRoute';
}

class InitialRouteArgs {
  const InitialRouteArgs({this.key});

  final _i7.Key? key;
}
