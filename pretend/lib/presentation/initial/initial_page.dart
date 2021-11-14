import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';
import 'package:core/dynamic_theme_app.dart';
import 'package:pretend/presentation/initial/theme_setter.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _settingsBloc = sl<SettingsBloc>()..add(GetAppSettingsEvent());

  Color? _color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (context, state) {
        double opacity = 0.0;
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          if (settings.themeColor == null) {
            opacity = 1.0;
          } else {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ThemeChanger.of(context)!.accentColor = settings.themeColor!;
            });
            context.router.replace(HomeRoute());
          }
        } else if (state is AppSettingsError) {
          opacity = 1.0;
        } else if (state is SettingsChangedSuccessfully) {
          _settingsBloc.add(GetAppSettingsEvent());
        }

        return Material(
          color: AppColors.DARK,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: state is AppSettingsError
                ? _buildErrorMessage(state.message)
                : _buildOnSettingsLoaded,
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(String message) => Center(child: Text(message));

  Widget get _buildOnSettingsLoaded {
    return Stack(
      children: [
        ThemeSetter(
          onColorChange: (newColor) => setState(() => _color = newColor),
        ),
        _buildHeader,
        AnimatedOpacity(
          opacity: _color == null ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: _buildOkButton,
        ),
      ],
    );
  }

  Widget get _buildOkButton {
    return Align(
      alignment: Alignment(0, 0.45),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _settingsBloc.add(SetThemeColorEvent(_color!)),
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget get _buildHeader {
    return Align(
      alignment: Alignment(0, -0.85),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Select a color",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColors.DARK),
          ),
          Text(
            "drag anywhere to change",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColors.DARK),
          ),
        ],
      ),
    );
  }
}
