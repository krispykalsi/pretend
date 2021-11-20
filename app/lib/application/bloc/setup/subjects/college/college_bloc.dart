import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/college.dart';
import 'package:pretend/domain/usecases/get_colleges.dart';
import 'package:pretend/domain/usecases/set_college_id.dart';

part 'college_event.dart';

part 'college_state.dart';

class CollegeBloc extends Bloc<CollegeEvent, CollegeState> {
  final GetColleges _getColleges;
  final SetCollegeID _setCollegeID;

  CollegeBloc({
    required GetColleges getColleges,
    required SetCollegeID setCollegeID,
  })  : _getColleges = getColleges,
        _setCollegeID = setCollegeID,
        super(CollegeInitial());

  @override
  Stream<CollegeState> mapEventToState(CollegeEvent event) async* {
    if (event is GetCollegesEvent) {
      yield DownloadingColleges();
      final collegesEither = await _getColleges(NoParams());
      yield collegesEither.fold(
        (failure) => failure is NoInternetFailure
            ? NoInternet()
            : CouldNotDownloadColleges(failure.message),
        (colleges) => DownloadedColleges(colleges),
      );
    } else if (event is SetCollegeIDEvent) {
      yield SettingCollegeID();
      final either = await _setCollegeID(SetCollegeIDParams(event.id));
      yield either.fold(
        (failure) => failure is NoInternetFailure
            ? NoInternet()
            : CouldNotDownloadColleges(failure.message),
        (_) => CollegeIDSetSuccessfully(),
      );
    }
  }
}
