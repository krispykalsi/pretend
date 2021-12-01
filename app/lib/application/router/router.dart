import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pretend/presentation/about/about_page.dart';
import 'package:pretend/presentation/home/home_page.dart';
import 'package:pretend/presentation/initial_page.dart';
import 'package:pretend/presentation/setup/subjects/setup_subjects_page.dart';
import 'package:pretend/presentation/setup/theme/theme_setup_page.dart';
import 'package:pretend/presentation/setup/timetable/timetable_setup_page.dart';
import 'package:pretend/presentation/setup/timetable/timetable_setup_status_page.dart';

@CustomAutoRouter(
  replaceInRouteName: "Page,Route",
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  durationInMilliseconds: 200,
  routes: [
    AutoRoute(page: HomePage),
    AutoRoute(page: SetupSubjectsPage),
    AutoRoute(page: TimetableSetupStatusPage),
    AutoRoute(page: TimetableSetupPage),
    AutoRoute(page: ThemeSetupPage),
    AutoRoute(page: AboutPage),
    CustomRoute(page: InitialPage, initial: true, transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
)
class $AppRouter {}
