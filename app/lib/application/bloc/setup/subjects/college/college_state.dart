part of 'college_bloc.dart';

abstract class CollegeState extends Equatable {
  const CollegeState();
}

class CollegeInitial extends CollegeState {
  @override
  List<Object> get props => [];
}

class DownloadingColleges extends CollegeState {
  const DownloadingColleges();

  @override
  List<Object?> get props => const [];
}

class DownloadedColleges extends CollegeState {
  final List<College> colleges;

  const DownloadedColleges(this.colleges);

  @override
  List<Object?> get props => [colleges];
}

class CouldNotDownloadColleges extends CollegeState {
  final String errorMsg;

  const CouldNotDownloadColleges(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

class SettingCollegeID extends CollegeState {
  const SettingCollegeID();

  @override
  List<Object?> get props => const [];
}

class CollegeIDSetSuccessfully extends CollegeState {
  const CollegeIDSetSuccessfully();

  @override
  List<Object?> get props => [];
}

class CouldNotSetCollegeID extends CollegeState {
  final String errorMsg;

  const CouldNotSetCollegeID(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

class NoInternet extends CollegeState {
  const NoInternet();

  @override
  List<Object?> get props => const [];
}
