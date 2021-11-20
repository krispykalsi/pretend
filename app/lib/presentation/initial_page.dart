import 'package:core/dynamic_theme_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _settingsBloc = sl<SettingsBloc>()..add(const GetAppSettingsEvent());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (context, state) {
        double opacity = 0.0;
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          if (settings.themeColor == null) {
            context.router.push(const ThemeSetupRoute()).then((_) {
              context.router.replace(const HomeRoute());
            });
          } else {
            ThemeChanger.of(context)!.accentColor = settings.themeColor!;
            context.router.replace(const HomeRoute());
          }
        } else if (state is AppSettingsError) {
          opacity = 1.0;
        }

        return Material(
          color: AppColors.DARK,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: state is AppSettingsError
                ? _buildErrorMessage(state.message)
                : CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(String message) => Center(child: Text(message));
}
