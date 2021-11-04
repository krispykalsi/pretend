import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pretend/presentation/setup/subjects/setup_subjects_page.dart';
import 'package:pretend/presentation/setup/timetable/timetable_setup_page.dart';
import 'package:pretend/presentation/setup/timetable/timetable_setup_status_page.dart';

@CustomAutoRouter(
  replaceInRouteName: "Page,Route",
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  durationInMilliseconds: 200,
  routes: [
    AutoRoute(page: SetupSubjectsPage, initial: true),
    AutoRoute(page: TimetableSetupStatusPage),
    AutoRoute(page: TimetableSetupPage)
  ],
)
class $AppRouter {}
