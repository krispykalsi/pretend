part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class GetAppSettingsEvent extends SettingsEvent {
  const GetAppSettingsEvent();

  @override
  List<Object?> get props => [];
}

class SetFirstTimeVisitedFlagEvent extends SettingsEvent {
  final bool flag;

  const SetFirstTimeVisitedFlagEvent(this.flag);

  @override
  List<Object?> get props => [];
}

class SetThemeColorEvent extends SettingsEvent {
  final Color color;

  const SetThemeColorEvent(this.color);

  @override
  List<Object?> get props => [];
}
