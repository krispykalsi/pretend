import 'package:core/app_colors.dart';
import 'package:core/dynamic_theme_app.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/injection_container.dart';
import 'package:auto_route/auto_route.dart';

import 'theme_setter.dart';

class ThemeSetupPage extends StatefulWidget {
  const ThemeSetupPage({Key? key}) : super(key: key);

  @override
  State<ThemeSetupPage> createState() => _ThemeSetupPageState();
}

class _ThemeSetupPageState extends State<ThemeSetupPage> {
  final _settingsBloc = sl<SettingsBloc>();

  Color? _color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _settingsBloc,
      builder: (context, state) {
        if (state is SettingsChangedSuccessfully) {
          ThemeChanger.of(context)!.accentColor = _color!;
          context.router.pop();
        }

        return Stack(
          children: [
            ThemeSetter(
              onColorChange: (newColor) => setState(() => _color = newColor),
            ),
            Align(
              alignment: const Alignment(0, -0.85),
              child: _buildHeader,
            ),
            Align(
              alignment: const Alignment(0, 0.45),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state is SettingsChangeError
                    ? _buildErrorState(state.message)
                    : _buildDefaultState,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildDefaultState {
    return AnimatedOpacity(
      opacity: _color == null || _settingsBloc.state == SettingsChangeInProgress
          ? 0
          : 1,
      duration: const Duration(milliseconds: 200),
      child: _buildButton("Ok"),
    );
  }

  Widget _buildErrorState(String errorMsg) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErrorPuu(title: "Couldn't change :(", body: errorMsg),
        SizedBox(height: 15),
        _buildButton("Retry"),
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _settingsBloc.add(SetThemeColorEvent(_color!)),
      child: Text(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.PRIMARY),
      ),
    );
  }

  Widget get _buildHeader {
    return Column(
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
    );
  }
}
