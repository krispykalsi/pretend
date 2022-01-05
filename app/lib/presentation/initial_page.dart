import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';
import 'package:core/dynamic_theme_app.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/deep_link/deep_link_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart';
import 'package:uri_to_file/uri_to_file.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _settingsBloc = sl<SettingsBloc>()..add(const GetAppSettingsEvent());
  final _deepLinkBloc = sl<DeepLinkBloc>();

  @override
  void initState() {
    super.initState();
    _deepLinkBloc.add(CheckForDeepLinksEvent());
  }

  @override
  void dispose() {
    _deepLinkBloc.add(DisposeDeepLinksEvent());
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
    return BlocBuilder(
      bloc: _deepLinkBloc,
      builder: (context, state) {
        if (state is DeepLinkNotFound) {
          context.router.replace(const HomeRoute());
        } else if (state is DeepLinkFound) {
          toFile(state.uri).then((file) {
            print(_getFileNameString(file));
            file.readAsString().then((value) => print(value));
          });
        } else if (state is DeepLinkError) {
          return ErrorPuu(title: "Error loading settings", body: state.msg);
        }
        return CircularProgressIndicator();
      },
    );
  }

  String _getFileNameString(File _file) {
    return _file.path
        .substring((_file.path.lastIndexOf(Platform.pathSeparator)) + 1);
  }

  Widget _setAppThemeColor() {
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (context, state) {
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          if (settings.themeColor == null) {
            context.router.push(const ThemeSetupRoute()).then((_) {
              _settingsBloc.add(const GetAppSettingsEvent());
            });
          } else {
            ThemeChanger.of(context)!.accentColor = settings.themeColor!;
            return _checkIfCameFromDeepLink();
          }
        } else if (state is AppSettingsError) {
          return _buildErrorWidget("Error loading settings", state.message);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildErrorWidget(String title, String msg) {
    return Material(
      color: AppColors.DARK,
      child: ErrorPuu(
        title: title,
        body: msg,
      ),
    );
  }
}
