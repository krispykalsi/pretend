// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../domain/entities/subject.dart' as _i10;
import '../../domain/entities/timeslots.dart' as _i12;
import '../../domain/entities/timetable.dart' as _i11;
import '../../presentation/about/about_page.dart' as _i6;
import '../../presentation/home/home_page.dart' as _i1;
import '../../presentation/initial_page.dart' as _i7;
import '../../presentation/setup/subjects/setup_subjects_page.dart' as _i2;
import '../../presentation/setup/theme/theme_setup_page.dart' as _i5;
import '../../presentation/setup/timetable/timeslot_grid_tile_state.dart'
    as _i13;
import '../../presentation/setup/timetable/timetable_setup_page.dart' as _i4;
import '../../presentation/setup/timetable/timetable_setup_status_page.dart'
    as _i3;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    SetupSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<SetupSubjectsRouteArgs>(
          orElse: () => const SetupSubjectsRouteArgs());
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.SetupSubjectsPage(
              key: args.key, selectedSubjects: args.selectedSubjects),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupStatusRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupStatusRouteArgs>();
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.TimetableSetupStatusPage(
              key: args.key,
              timetable: args.timetable,
              canGoBack: args.canGoBack,
              subjects: args.subjects),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    TimetableSetupRoute.name: (routeData) {
      final args = routeData.argsAs<TimetableSetupRouteArgs>();
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TimetableSetupPage(
              key: args.key,
              subject: args.subject,
              selectionState: args.selectionState),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    ThemeSetupRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.ThemeSetupPage(),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    AboutRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.AboutPage(),
          transitionsBuilder: _i8.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    InitialRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i7.InitialPage(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i8.RouteConfig(SetupSubjectsRoute.name, path: '/setup-subjects-page'),
        _i8.RouteConfig(TimetableSetupStatusRoute.name,
            path: '/timetable-setup-status-page'),
        _i8.RouteConfig(TimetableSetupRoute.name,
            path: '/timetable-setup-page'),
        _i8.RouteConfig(ThemeSetupRoute.name, path: '/theme-setup-page'),
        _i8.RouteConfig(AboutRoute.name, path: '/about-page'),
        _i8.RouteConfig(InitialRoute.name, path: '/')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.SetupSubjectsPage]
class SetupSubjectsRoute extends _i8.PageRouteInfo<SetupSubjectsRouteArgs> {
  SetupSubjectsRoute(
      {_i9.Key? key, List<_i10.Subject> selectedSubjects = const []})
      : super(SetupSubjectsRoute.name,
            path: '/setup-subjects-page',
            args: SetupSubjectsRouteArgs(
                key: key, selectedSubjects: selectedSubjects));

  static const String name = 'SetupSubjectsRoute';
}

class SetupSubjectsRouteArgs {
  const SetupSubjectsRouteArgs({this.key, this.selectedSubjects = const []});

  final _i9.Key? key;

  final List<_i10.Subject> selectedSubjects;

  @override
  String toString() {
    return 'SetupSubjectsRouteArgs{key: $key, selectedSubjects: $selectedSubjects}';
  }
}

/// generated route for
/// [_i3.TimetableSetupStatusPage]
class TimetableSetupStatusRoute
    extends _i8.PageRouteInfo<TimetableSetupStatusRouteArgs> {
  TimetableSetupStatusRoute(
      {_i9.Key? key,
      _i11.Timetable? timetable,
      bool canGoBack = true,
      required List<_i10.Subject> subjects})
      : super(TimetableSetupStatusRoute.name,
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

  final _i9.Key? key;

  final _i11.Timetable? timetable;

  final bool canGoBack;

  final List<_i10.Subject> subjects;

  @override
  String toString() {
    return 'TimetableSetupStatusRouteArgs{key: $key, timetable: $timetable, canGoBack: $canGoBack, subjects: $subjects}';
  }
}

/// generated route for
/// [_i4.TimetableSetupPage]
class TimetableSetupRoute extends _i8.PageRouteInfo<TimetableSetupRouteArgs> {
  TimetableSetupRoute(
      {_i9.Key? key,
      required _i10.Subject subject,
      Map<String, Map<_i12.Timeslots, _i13.TimeslotGridTileState>>?
          selectionState})
      : super(TimetableSetupRoute.name,
            path: '/timetable-setup-page',
            args: TimetableSetupRouteArgs(
                key: key, subject: subject, selectionState: selectionState));

  static const String name = 'TimetableSetupRoute';
}

class TimetableSetupRouteArgs {
  const TimetableSetupRouteArgs(
      {this.key, required this.subject, this.selectionState});

  final _i9.Key? key;

  final _i10.Subject subject;

  final Map<String, Map<_i12.Timeslots, _i13.TimeslotGridTileState>>?
      selectionState;

  @override
  String toString() {
    return 'TimetableSetupRouteArgs{key: $key, subject: $subject, selectionState: $selectionState}';
  }
}

/// generated route for
/// [_i5.ThemeSetupPage]
class ThemeSetupRoute extends _i8.PageRouteInfo<void> {
  const ThemeSetupRoute()
      : super(ThemeSetupRoute.name, path: '/theme-setup-page');

  static const String name = 'ThemeSetupRoute';
}

/// generated route for
/// [_i6.AboutPage]
class AboutRoute extends _i8.PageRouteInfo<void> {
  const AboutRoute() : super(AboutRoute.name, path: '/about-page');

  static const String name = 'AboutRoute';
}

/// generated route for
/// [_i7.InitialPage]
class InitialRoute extends _i8.PageRouteInfo<void> {
  const InitialRoute() : super(InitialRoute.name, path: '/');

  static const String name = 'InitialRoute';
}
