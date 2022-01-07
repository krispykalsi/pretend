import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';
import 'package:core/dynamic_theme_app.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/initial/deep_link/deep_link_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _settingsBloc = sl<SettingsBloc>()..add(const GetAppSettingsEvent());
  final _deepLinkBloc = sl<DeepLinkBloc>();

  @override
  void dispose() {
    _deepLinkBloc.add(const DisposeDeepLinksEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.DARK,
      child: Center(
        child: _setAppThemeColor(),
      ),
    );
  }

  Widget _checkIfCameFromDeepLink() {
    return BlocConsumer(
      bloc: _deepLinkBloc,
      listener: (context, state) {
        if (state is DeepLinkNotFound) {
          context.router.replace(const HomeRoute());
        } else if (state is ImportSuccessful) {
          final subjects = state.tws.subjects.values.toList();
          context.router.replace(
            TimetableSetupStatusRoute(
              subjects: subjects,
              timetable: state.tws.timetable,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DeepLinkError) {
          return ErrorPuu(title: "Error with deeplink", body: state.msg);
        } else if (state is ImportFailed) {
          return ErrorPuu(title: "Import failed", body: state.msg);
        } else if (state is ImportInProgress) {
          return _importingProgressIndicator;
        } else {
          if (state is DeepLinkInitial) {
            _deepLinkBloc.add(const CheckForDeepLinksEvent());
          }
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget get _importingProgressIndicator {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("Importing..."),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _setAppThemeColor() {
    return BlocConsumer(
      bloc: _settingsBloc,
      listener: (context, state) async {
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          if (settings.themeColor == null) {
            await context.router.push(const ThemeSetupRoute());
            _settingsBloc.add(const GetAppSettingsEvent());
          } else {
            ThemeChanger.of(context)!.accentColor = settings.themeColor!;
          }
        }
      },
      builder: (context, state) {
        if (state is AppSettingsLoaded && state.settings.themeColor != null) {
          return _checkIfCameFromDeepLink();
        } else if (state is AppSettingsError) {
          return ErrorPuu(title: "Error loading settings", body: state.message);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
