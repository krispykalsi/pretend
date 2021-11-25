// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../domain/entities/subject.dart' as _i9;
import '../../domain/entities/timeslots.dart' as _i11;
import '../../domain/entities/timetable.dart' as _i10;
import '../../presentation/home/home_page.dart' as _i1;
import '../../presentation/initial_page.dart' as _i6;
import '../../presentation/setup/subjects/setup_subjects_page.dart' as _i2;
import '../../presentation/setup/theme/theme_setup_page.dart' as _i5;
import '../../presentation/setup/timetable/timeslot_grid_tile_state.dart'
    as _i12;
import '../../presentation/setup/timetable/timetable_setup_page.dart' as _i4;
import '../../presentation/setup/timetable/timetable_setup_status_page.dart'
    as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    SetupSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<SetupSubjectsRouteArgs>(
          orElse: () => const SetupSubjectsRouteArgs());
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.SetupSubjectsPage(
              key: args.key, selectedSubjects: args.selectedSubjects),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupStatusRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupStatusRouteArgs>();
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.TimetableSetupStatusPage(
              key: args.key,
              timetable: args.timetable,
              canGoBack: args.canGoBack,
              subjects: args.subjects),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupRouteArgs>();
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TimetableSetupPage(
              key: args.key,
              subject: args.subject,
              selectionState: args.selectionState),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    ThemeSetupRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.ThemeSetupPage(),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    InitialRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.InitialPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i7.RouteConfig(SetupSubjectsRoute.name, path: '/setup-subjects-page'),
        _i7.RouteConfig(TimetableSetupStatusRoute.name,
            path: '/timetable-setup-status-page'),
        _i7.RouteConfig(TimetableSetupRoute.name,
            path: '/timetable-setup-page'),
        _i7.RouteConfig(ThemeSetupRoute.name, path: '/theme-setup-page'),
        _i7.RouteConfig(InitialRoute.name, path: '/')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.SetupSubjectsPage]
class SetupSubjectsRoute extends _i7.PageRouteInfo<SetupSubjectsRouteArgs> {
  SetupSubjectsRoute(
      {_i8.Key? key, List<_i9.Subject> selectedSubjects = const []})
      : super(name,
            path: '/setup-subjects-page',
            args: SetupSubjectsRouteArgs(
                key: key, selectedSubjects: selectedSubjects));

  static const String name = 'SetupSubjectsRoute';
}

class SetupSubjectsRouteArgs {
  const SetupSubjectsRouteArgs({this.key, this.selectedSubjects = const []});

  final _i8.Key? key;

  final List<_i9.Subject> selectedSubjects;
}

/// generated route for [_i3.TimetableSetupStatusPage]
class TimetableSetupStatusRoute
    extends _i7.PageRouteInfo<TimetableSetupStatusRouteArgs> {
  TimetableSetupStatusRoute(
      {_i8.Key? key,
      _i10.Timetable? timetable,
      bool canGoBack = true,
      required List<_i9.Subject> subjects})
      : super(name,
            path: '/timetable-setup-status-page',
            args: TimetableSetupStatusRouteArgs(
                key: key,
                timetable: timetable,
                canGoBack: canGoBack,
                subjects: subjects));

  static const String name = 'TimetableSetupStatusRoute';
}

class TimetableSetupStatusRouteArgs {
  const TimetableSetupStatusRouteArgs(
      {this.key,
      this.timetable,
      this.canGoBack = true,
      required this.subjects});

  final _i8.Key? key;

  final _i10.Timetable? timetable;

  final bool canGoBack;

  final List<_i9.Subject> subjects;
}

/// generated route for [_i4.TimetableSetupPage]
class TimetableSetupRoute extends _i7.PageRouteInfo<TimetableSetupRouteArgs> {
  TimetableSetupRoute(
      {_i8.Key? key,
      required _i9.Subject subject,
      Map<String, Map<_i11.Timeslots, _i12.TimeslotGridTileState>>?
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

  final _i8.Key? key;

  final _i9.Subject subject;

  final Map<String, Map<_i11.Timeslots, _i12.TimeslotGridTileState>>?
      selectionState;
}

/// generated route for [_i5.ThemeSetupPage]
class ThemeSetupRoute extends _i7.PageRouteInfo<void> {
  const ThemeSetupRoute() : super(name, path: '/theme-setup-page');

  static const String name = 'ThemeSetupRoute';
}

/// generated route for [_i6.InitialPage]
class InitialRoute extends _i7.PageRouteInfo<void> {
  const InitialRoute() : super(name, path: '/');

  static const String name = 'InitialRoute';
}
