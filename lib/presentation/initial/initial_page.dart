import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class InitialPage extends StatelessWidget {
  final _settingsBloc = sl<SettingsBloc>()..add(GetAppSettingsEvent());

  InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (context, state) {
        double opacity = 0.0;
        String text = "hello person";
        print(state);
        if (state is AppSettingsLoaded) {
          final settings = state.settings;
          print(settings);
          if (settings.firstTimeStartup) {
            opacity = 1.0;
          } else {
            print("here");
            context.router.replace(HomeRoute());
          }
        } else if (state is AppSettingsError) {
          text = state.message;
          opacity = 1.0;
        } else if (state is SettingsChangedSuccessfully) {
          _settingsBloc.add(GetAppSettingsEvent());
        }

        return Material(
          color: AppColors.DARK,
          child: Center(
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text),
                  IconButton(
                    onPressed: () {
                      _settingsBloc.add(SetFirstTimeVisitedFlagEvent(false));
                    },
                    icon: Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
