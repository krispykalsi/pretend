import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/core/usecases/usecase.dart';
import 'package:pretend/domain/entities/app_settings.dart';
import 'package:pretend/domain/usecases/get_app_settings.dart';
import 'package:pretend/domain/usecases/mark_app_visited_first_time.dart';
import 'package:pretend/domain/usecases/set_app_theme_color.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetAppSettings _getAppSettings;
  final MarkAppVisitedFirstTime _markAppVisitedFirstTime;
  final SetAppThemeColor _setAppThemeColor;

  SettingsBloc({
    required GetAppSettings getAppSettings,
    required MarkAppVisitedFirstTime markAppVisitedFirstTime,
    required SetAppThemeColor setAppThemeColor,
  })  : _getAppSettings = getAppSettings,
        _markAppVisitedFirstTime = markAppVisitedFirstTime,
        _setAppThemeColor = setAppThemeColor,
        super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is GetAppSettingsEvent) {
      yield AppSettingsLoading();
      final settingsEither = await _getAppSettings(NoParams());
      yield settingsEither.fold(
        (failure) => AppSettingsError(failure.message),
        (appSettings) => AppSettingsLoaded(appSettings),
      );
    } else if (event is SetFirstTimeVisitedFlagEvent) {
      yield SettingsChangeInProgress();
      final settingsEither = await _markAppVisitedFirstTime(NoParams());
      yield settingsEither.fold(
        (failure) => SettingsChangeError(failure.message),
        (_) => SettingsChangedSuccessfully(),
      );
    } else if (event is SetThemeColorEvent) {
      yield SettingsChangeInProgress();
      final settingsEither =
          await _setAppThemeColor(SetAppThemeColorParams(event.color));
      yield settingsEither.fold(
        (failure) => SettingsChangeError(failure.message),
        (_) => SettingsChangedSuccessfully(),
      );
    }
  }
}
