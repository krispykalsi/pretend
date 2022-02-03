import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/entities/timetable.dart';
import 'package:pretend/domain/repositories/timetable_repository_contract.dart';
import 'package:pretend/domain/usecases/toggle_notifications.dart';

class SetTimetable extends UseCase<void, SetTimetableParams> {
  final TimetableRepositoryContract repository;
  final ToggleNotifications toggleNotifications;

  SetTimetable(this.repository, this.toggleNotifications);

  @override
  Future<Either<Failure, void>> call(SetTimetableParams params) async {
    final either = await repository.setTimetable(params.timetable);
    return either.fold(
      (failure) => Left(failure),
      (_) async {
        final params = ToggleNotificationsParams(Notifications.REFRESH);
        await toggleNotifications(params);
        return either;
      },
    );
  }
}

class SetTimetableParams extends Equatable {
  final Timetable timetable;

  const SetTimetableParams(this.timetable);

  @override
  List<Object?> get props => [timetable];
}
