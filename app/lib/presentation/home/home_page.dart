import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pretend/application/bloc/home/home_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/injection_container.dart';
import 'package:share_plus/share_plus.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _homeBloc = sl<HomeBloc>();

  void _editTimetable(Timetable timetable, List<Subject> subjects) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.router.push(
        TimetableSetupStatusRoute(subjects: subjects, timetable: timetable),
      );
    });
  }

  void _changeThemeColor() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.router.push(ThemeSetupRoute()).then((_) => setState(() {}));
    });
  }

  void _exportTimetable() {
    _homeBloc.add(const ExportTimetableEvent());
  }

  @override
  void initState() {
    super.initState();
    _homeBloc.add(GetTimetableEvent(DateTime.now()));
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _homeBloc.add(const CancelTimetableRefreshTimerEvent());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _homeBloc.add(RefreshScheduleEvent(DateTime.now()));
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _homeBloc.add(const CancelTimetableRefreshTimerEvent());
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.DARK,
      child: LoaderOverlay(
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: _homeBloc,
          listener: (context, state) {
            if (state is ExportInProgress) {
              context.loaderOverlay.show();
            } else {
              if (state is ExportSuccessful) {
                Share.shareFiles([state.pathToFile]);
              } else if (state is ExportFailed) {
                Fluttertoast.showToast(msg: state.message);
              }

              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
            }
          },
          builder: (context, state) {
            if (state is TimetableLoaded) {
              return Home(
                timetable: state.timetable,
                subjects: state.subjects,
                filteredSchedule: state.filteredSchedule,
                changeThemeColor: _changeThemeColor,
                editTimetable: _editTimetable,
                exportTimetable: _exportTimetable,
              );
            } else if (state is TimetableLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TimetableNotFound) {
              context.router.replace(TimetableSetupStatusRoute(
                subjects: const [],
                canGoBack: false,
              ));
            } else if (state is TimetableError) {
              return ErrorPuu(
                title: "Couldn't load timetable",
                body: state.message,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
